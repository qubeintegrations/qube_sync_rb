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
end