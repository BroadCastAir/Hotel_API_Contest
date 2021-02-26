Class Data.GuestStayRelation Extends %Library.Persistent [ Not Abstract, DdlAllowed, Not LegacyInstanceContext, ProcedureBlock ]
{

Property checkincategory As %Library.String(MAXLEN = 250) [ SqlColumnNumber = 2, SqlFieldName = checkin_category ];

Property custcategory As %Library.String(MAXLEN = 250) [ SqlColumnNumber = 3, SqlFieldName = cust_category ];

Property noshownum As %Library.Integer(MAXVAL = 2147483647, MINVAL = -2147483648) [ SqlColumnNumber = 4, SqlFieldName = noshow_num ];

ClassMethod Import(pSelectMode As %Library.Integer = {$zu(115,5)}, pFileName As %Library.String(MAXLEN=""), pDelimiter As %String = ",", pQuote As %String = """", pHeaders As %Integer = 0, ByRef pRecordCount As %Integer) As %Library.Integer [ SqlProc ]
{
	set tStatementId = $SYSTEM.Util.CreateGUID(), tCounter = 0, pRecordCount = 0
	set tPreparedStatement = ##class(%SQL.DynamicStatement).Prepare(tStatementId,..#ROWTYPE,pDelimiter,pQuote,,,0,"CSV")
	if $Isobject(tPreparedStatement) {
		set tImporter = tPreparedStatement.%New(tPreparedStatement,,pFileName,pDelimiter,pQuote)
		if $Isobject(tImporter) {
			do ..%DeleteExtent(,.tDeleted,.tInstances,1)
				// burn the column headers
			for tPtr = 1:1:pHeaders { do tImporter.%Next() }
			while tImporter.%Next() {
				set tMe = ..%New()
				if 'pSelectMode {
					set tMe.checkincategory = tImporter.%GetData(1)
					set tMe.custcategory = tImporter.%GetData(2)
					set tMe.noshownum = tImporter.%GetData(3)
				}
				elseif pSelectMode = 1 {
					set tMe.checkincategory = $s('$system.CLS.IsMthd("checkincategoryOdbcToLogical"):tImporter.%GetData(1),1:tMe.checkincategoryOdbcToLogical(tImporter.%GetData(1)))
					set tMe.custcategory = $s('$system.CLS.IsMthd("custcategoryOdbcToLogical"):tImporter.%GetData(2),1:tMe.custcategoryOdbcToLogical(tImporter.%GetData(2)))
					set tMe.noshownum = $s('$system.CLS.IsMthd("noshownumOdbcToLogical"):tImporter.%GetData(3),1:tMe.noshownumOdbcToLogical(tImporter.%GetData(3)))
				}
				elseif pSelectMode = 2 {
					set tMe.checkincategory = $s('$system.CLS.IsMthd("checkincategoryDisplayToLogical"):tImporter.%GetData(1),1:tMe.checkincategoryDisplayToLogical(tImporter.%GetData(1)))
					set tMe.custcategory = $s('$system.CLS.IsMthd("custcategoryDisplayToLogical"):tImporter.%GetData(2),1:tMe.custcategoryDisplayToLogical(tImporter.%GetData(2)))
					set tMe.noshownum = $s('$system.CLS.IsMthd("noshownumDisplayToLogical"):tImporter.%GetData(3),1:tMe.noshownumDisplayToLogical(tImporter.%GetData(3)))
				}
				set tStatus = tMe.%Save()
				if $$$ISOK(tStatus) { set tCounter = tCounter + 1 }
			}
		}
	}
	set %sqlcontext.%SQLCODE = 0
	set %sqlcontext.%ROWCOUNT = tCounter
	set pRecordCount = tCounter
	quit tCounter
}

Parameter ROWTYPE = "checkin_category VARCHAR(250),cust_category VARCHAR(250),noshow_num INTEGER";

Storage Default
{
<Data name="GuestStayRelationDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>checkincategory</Value>
</Value>
<Value name="3">
<Value>custcategory</Value>
</Value>
<Value name="4">
<Value>noshownum</Value>
</Value>
</Data>
<DataLocation>^Data.GuestStayRelationD</DataLocation>
<DefaultData>GuestStayRelationDefaultData</DefaultData>
<IdLocation>^Data.GuestStayRelationD</IdLocation>
<IndexLocation>^Data.GuestStayRelationI</IndexLocation>
<StreamLocation>^Data.GuestStayRelationS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
