Class dc.Sample.oversold Extends %CSP.REST
{

Parameter HandleCorsRequest = 1;

XData UrlMap [ XMLNamespace = "http://www.intersystems.com/urlmap" ]
{
<Routes>
      <Route Url="/test" Method="GET" Call="test"/>
      <Route Url="/all" Method="GET" Call="GetAll" /> 
      <Route Url="/:id" Method="GET" Call="GetSingle" /> 
   </Routes>
}

ClassMethod GetAll() As %Status
{
  Set tArr = []
  Set rs = ##class(%SQL.Statement).%ExecDirect(,"SELECT * FROM Data.Oversold")
  While rs.%Next() {
    Do tArr.%Push({
      "ID":                 (rs.%Get("ID")),
      "booking_date":       (rs.%Get("booking_date")),
      "room_price":         (rs.%Get("room_price")),
      "room_max":           (rs.%Get("room_max")),
      "unshow_fore":        (rs.%Get("unshow_fore")),
      "resultMax":          (rs.%Get("resultMax")),
      "resultMax_sold":     (rs.%Get("resultMax_sold")),
      "arrival_rate":       (rs.%Get("arrival_rate")),
      "arrival_rate_fore":  (rs.%Get("arrival_rate_fore"))
    })
  }
  
  Write tArr.%ToJSON()
  Quit $$$OK
}

ClassMethod GetSingle(id As %Integer) As %Status
{
  Set tArr = []
  Set rs = ##class(%SQL.Statement).%ExecDirect(,"SELECT * FROM Data.Oversold where ID = ?" , id)
  While rs.%Next() {
    Do tArr.%Push({
      "ID":                 (rs.%Get("ID")),
      "booking_date":       (rs.%Get("booking_date")),
      "room_price":         (rs.%Get("room_price")),
      "room_max":           (rs.%Get("room_max")),
      "unshow_fore":        (rs.%Get("unshow_fore")),
      "resultMax":          (rs.%Get("resultMax")),
      "resultMax_sold":     (rs.%Get("resultMax_sold")),
      "arrival_rate":       (rs.%Get("arrival_rate")),
      "arrival_rate_fore":  (rs.%Get("arrival_rate_fore"))
    })
  }
  
  Write tArr.%ToJSON()
  Quit $$$OK
}

}
