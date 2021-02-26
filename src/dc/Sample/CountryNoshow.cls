Class dc.Sample.CountryNoshow Extends %CSP.REST
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
  Set rs = ##class(%SQL.Statement).%ExecDirect(,"SELECT * FROM Data.CountryNoshow")
  While rs.%Next() {
    Do tArr.%Push({
      "ID":                 (rs.%Get("ID")),
      "country":            (rs.%Get("country")),
      "noshow_amount":      (rs.%Get("noshow_amount"))
    })
  }
  
  Write tArr.%ToJSON()
  Quit $$$OK
}

ClassMethod GetSingle(id As %Integer) As %Status
{
  Set tArr = []
  Set rs = ##class(%SQL.Statement).%ExecDirect(,"SELECT * FROM Data.CountryNoshow where ID = ?" , id)
  While rs.%Next() {
    Do tArr.%Push({
      "ID":                 (rs.%Get("ID")),
      "country":            (rs.%Get("country")),
      "noshow_amount":      (rs.%Get("noshow_amount"))
    })
  }
  
  Write tArr.%ToJSON()
  Quit $$$OK
}

}
