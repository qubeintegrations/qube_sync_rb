RSpec.describe QubeSync::RequestBuilder do  
  it "builds the correct JSON" do
    request_id = "asdf1234"
    max_returned = 20
    request = QubeSync::RequestBuilder.new(version: "16.0") do |r|
      r.QBXML {
        r.QBXMLMsgsRq('onError' => 'stopOnError') {
          r.CustomerQueryRq('requestID' => request_id, 'iterator' => 'Start') {
            r.MaxReturned max_returned
            r.IncludeRetElement 'ListID'
            r.IncludeRetElement 'Name'
            r.IncludeRetElement 'FullName'
            r.IncludeRetElement 'IsActive'
          }
        }
      }
    end

    expected_json = {
      "version" => "16.0",
      "request" => [
        {"name" => "QBXML", "children" => [
          {"name" => "QBXMLMsgsRq", "attributes" => {"onError" => "stopOnError"}, "children" => [
            {
              "name" => "CustomerQueryRq", 
              "attributes" => {"requestID" => request_id, "iterator" => "Start"}, 
              "children" => [
                {"name" => "MaxReturned", "text" => 20},
                {"name" => "IncludeRetElement", "text" => "ListID"},
                {"name" => "IncludeRetElement", "text" => "Name"},
                {"name" => "IncludeRetElement", "text" => "FullName"},
                {"name" => "IncludeRetElement", "text" => "IsActive"}
              ]
            }
        ]}
      ]}
    ]}

    expect(request.as_json).to eq(expected_json)
  end

  # The builder yields itself: every tag goes through the block's argument,
  # and the block runs where it was written, so names in it mean what they
  # mean there. (`instance_eval` made the builder `self`, and an app's method
  # or instance variable silently became a tag or nil.)
  describe "building from inside an app" do
    let(:app_class) do
      Class.new do
        attr_reader :limit

        def initialize
          @limit = 10
          @owner_id = "0"
        end

        def customer_query
          request_id = "q1"

          QubeSync::RequestBuilder.new(version: "16.0") do |b|
            b.QBXML {
              b.QBXMLMsgsRq(onError: "stopOnError") {
                b.CustomerQueryRq(requestID: request_id) {
                  b.MaxReturned limit
                  b.OwnerID @owner_id
                  b.FromModifiedDate modified_since
                }
              }
            }
          end
        end

        def with_typo
          QubeSync::RequestBuilder.new(version: "16.0") do |b|
            b.QBXML { b.MaxReturned(limt) }
          end
        end

        def without_receiver
          QubeSync::RequestBuilder.new(version: "16.0") do
            QBXML { MaxReturned(limit) }
          end
        end

        private

        def modified_since
          "2026-01-01"
        end
      end
    end

    let(:app) { app_class.new }

    def query_children(request)
      request.as_json["request"][0]["children"][0]["children"][0]
    end

    it "reads local variables, the app's methods (public and private) and its instance variables" do
      query = query_children(app.customer_query)

      expect(query["attributes"]).to eq(requestID: "q1")
      expect(query["children"]).to eq([
        {"name" => "MaxReturned", "text" => 10},
        {"name" => "OwnerID", "text" => "0"},
        {"name" => "FromModifiedDate", "text" => "2026-01-01"}
      ])
    end

    it "raises on a misspelled name instead of sending it as a tag" do
      expect { app.with_typo }.to raise_error(NameError, /limt/)
    end

    it "raises on a tag called without the block's argument" do
      expect { app.without_receiver }.to raise_error(NoMethodError, /QBXML/)
    end
  end

  describe "nesting" do
    it "puts siblings after a nested element under the right parent" do
      request = QubeSync::RequestBuilder.new(version: "16.0") do |b|
        b.QBXML {
          b.QBXMLMsgsRq {
            b.InvoiceAddRq {
              b.InvoiceAdd {
                b.CustomerRef { b.ListID "80000001" }
                b.InvoiceLineAdd { b.Amount 5 }
                b.InvoiceLineAdd { b.Amount 7.5 }
                b.Memo "after the lines"
              }
            }
            b.CustomerQueryRq { b.MaxReturned 1 }
          }
        }
      end

      msgs = request.as_json["request"][0]["children"][0]
      invoice_add = msgs["children"][0]["children"][0]

      expect(invoice_add["children"]).to eq([
        {"name" => "CustomerRef", "children" => [{"name" => "ListID", "text" => "80000001"}]},
        {"name" => "InvoiceLineAdd", "children" => [{"name" => "Amount", "text" => 5}]},
        {"name" => "InvoiceLineAdd", "children" => [{"name" => "Amount", "text" => 7.5}]},
        {"name" => "Memo", "text" => "after the lines"}
      ])
      expect(msgs["children"][1]).to eq(
        "name" => "CustomerQueryRq",
        "children" => [{"name" => "MaxReturned", "text" => 1}]
      )
    end

    it "builds elements in a loop" do
      names = %w[ListID Name FullName]

      request = QubeSync::RequestBuilder.new(version: "16.0") do |b|
        b.CustomerQueryRq {
          names.each { |name| b.IncludeRetElement name }
        }
      end

      expect(request.as_json["request"][0]["children"]).to eq(
        names.map { |name| {"name" => "IncludeRetElement", "text" => name} }
      )
    end

    it "keeps an element with an empty block, with no children" do
      request = QubeSync::RequestBuilder.new(version: "16.0") { |b| b.CustomerQueryRq {} }

      expect(request.as_json["request"]).to eq([{"name" => "CustomerQueryRq", "children" => []}])
    end

    it "keeps several top-level elements in order" do
      request = QubeSync::RequestBuilder.new(version: "16.0") do |b|
        b.First "1"
        b.Second "2"
      end

      expect(request.as_json["request"].map { |e| e["name"] }).to eq(%w[First Second])
    end
  end

  describe "an element's attributes and text" do
    it "takes a hash as attributes and a string or number as text" do
      request = QubeSync::RequestBuilder.new(version: "16.0") do |b|
        b.CustomerQueryRq("requestID" => "1", "iterator" => "Start")
        b.Name "Acme"
        b.MaxReturned 20
      end

      expect(request.as_json["request"]).to eq([
        {"name" => "CustomerQueryRq", "attributes" => {"requestID" => "1", "iterator" => "Start"}},
        {"name" => "Name", "text" => "Acme"},
        {"name" => "MaxReturned", "text" => 20}
      ])
    end

    it "sends true and false as qbXML's words for them" do
      request = QubeSync::RequestBuilder.new(version: "16.0") do |b|
        b.IsActive true
        b.IncludeLineItems false
      end

      expect(request.as_json["request"]).to eq([
        {"name" => "IsActive", "text" => "true"},
        {"name" => "IncludeLineItems", "text" => "false"}
      ])
    end

    it "leaves out an empty hash and nil" do
      request = QubeSync::RequestBuilder.new(version: "16.0") do |b|
        b.Empty({})
        b.Nothing nil
      end

      expect(request.as_json["request"]).to eq([{"name" => "Empty"}, {"name" => "Nothing"}])
    end
  end

  it "builds an empty request without a block" do
    expect(QubeSync::RequestBuilder.new(version: "13.0").as_json).to eq("version" => "13.0", "request" => [])
  end
end
