Class dc.Sample.NumPriceChannel Extends %CSP.REST
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
  Set rs = ##class(%SQL.Statement).%ExecDirect(,"SELECT * FROM Data.NumPriceChannel")
  While rs.%Next() {
    Do tArr.%Push({
      "ID":                     (rs.%Get("ID")),
      "cust_channel":           (rs.%Get("cust_channel")),
      "room_price":             (rs.%Get("room_price"))
    })
  }
  
  Write tArr.%ToJSON()
  Quit $$$OK
}

ClassMethod GetSingle(id As %Integer) As %Status
{
  Set tArr = []
  Set rs = ##class(%SQL.Statement).%ExecDirect(,"SELECT * FROM Data.NumPriceChannel where ID = ?" , id)
  While rs.%Next() {
    Do tArr.%Push({
      "ID":                     (rs.%Get("ID")),
      "cust_channel":           (rs.%Get("cust_channel")),
      "room_price":             (rs.%Get("room_price"))
    })
  }
  
  Write tArr.%ToJSON()
  Quit $$$OK
}

}
