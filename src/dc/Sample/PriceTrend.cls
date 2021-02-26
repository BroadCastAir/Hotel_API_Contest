Class dc.Sample.PriceTrend Extends %CSP.REST
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
  Set rs = ##class(%SQL.Statement).%ExecDirect(,"SELECT * FROM Data.PriceTrend")
  While rs.%Next() {
    Do tArr.%Push({
      "ID":                     (rs.%Get("ID")),
      "date":                   (rs.%Get("date")),
      "uncanceled_num":         (rs.%Get("uncanceled_num")),
      "room_price":             (rs.%Get("room_price"))
    })
  }
  
  Write tArr.%ToJSON()
  Quit $$$OK
}

ClassMethod GetSingle(id As %Integer) As %Status
{
  Set tArr = []
  Set rs = ##class(%SQL.Statement).%ExecDirect(,"SELECT * FROM Data.PriceTrend where ID = ?" , id)
  While rs.%Next() {
    Do tArr.%Push({
      "ID":                     (rs.%Get("ID")),
      "date":                   (rs.%Get("date")),
      "uncanceled_num":         (rs.%Get("uncanceled_num")),
      "room_price":             (rs.%Get("room_price"))
    })
  }
  
  Write tArr.%ToJSON()
  Quit $$$OK
}

}
