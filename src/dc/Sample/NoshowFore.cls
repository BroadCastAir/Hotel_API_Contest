Class dc.Sample.NoshowFore Extends %CSP.REST
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
  Set rs = ##class(%SQL.Statement).%ExecDirect(,"SELECT * FROM Data.NoshowFore")
  While rs.%Next() {
    Do tArr.%Push({
      "ID":                     (rs.%Get("ID")),
      "date_fore":              (rs.%Get("date_fore")),
      "room_num":               (rs.%Get("room_num")),
      "resultMax_sold":         (rs.%Get("resultMax_sold")),
      "oversold_num":           (rs.%Get("oversold_num")),
      "offline":                (rs.%Get("offline")),
      "online":                 (rs.%Get("online"))
    })
  }
  
  Write tArr.%ToJSON()
  Quit $$$OK
}

ClassMethod GetSingle(id As %Integer) As %Status
{
  Set tArr = []
  Set rs = ##class(%SQL.Statement).%ExecDirect(,"SELECT * FROM Data.NoshowFore where ID = ?" , id)
  While rs.%Next() {
    Do tArr.%Push({
      "ID":                     (rs.%Get("ID")),
      "date_fore":              (rs.%Get("date_fore")),
      "room_num":               (rs.%Get("room_num")),
      "resultMax_sold":         (rs.%Get("resultMax_sold")),
      "oversold_num":           (rs.%Get("oversold_num")),
      "offline":                (rs.%Get("offline")),
      "online":                 (rs.%Get("online"))
    })
  }
  
  Write tArr.%ToJSON()
  Quit $$$OK
}

}
