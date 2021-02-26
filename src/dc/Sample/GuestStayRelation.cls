Class dc.Sample.GuestStayRelation Extends %CSP.REST
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
  Set rs = ##class(%SQL.Statement).%ExecDirect(,"SELECT * FROM Data.GuestStayRelation")
  While rs.%Next() {
    Do tArr.%Push({
      "ID":                     (rs.%Get("ID")),
      "checkin_category":       (rs.%Get("checkin_category")),
      "cust_category":          (rs.%Get("cust_category")),
      "noshow_num":             (rs.%Get("noshow_num"))
    })
  }
  
  Write tArr.%ToJSON()
  Quit $$$OK
}

ClassMethod GetSingle(id As %Integer) As %Status
{
  Set tArr = []
  Set rs = ##class(%SQL.Statement).%ExecDirect(,"SELECT * FROM Data.GuestStayRelation where ID = ?" , id)
  While rs.%Next() {
    Do tArr.%Push({
      "ID":                     (rs.%Get("ID")),
      "checkin_category":       (rs.%Get("checkin_category")),
      "cust_category":          (rs.%Get("cust_category")),
      "noshow_num":             (rs.%Get("noshow_num"))
    })
  }
  
  Write tArr.%ToJSON()
  Quit $$$OK
}

}
