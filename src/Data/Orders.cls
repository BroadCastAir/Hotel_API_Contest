Class Data.Orders Extends %Library.Persistent [ Not Abstract, DdlAllowed, Not LegacyInstanceContext, ProcedureBlock ]
{

Property month As %Library.Integer(MAXVAL = 2147483647, MINVAL = -2147483648) [ SqlColumnNumber = 2 ];

Property noshowcount As %Library.Double [ SqlColumnNumber = 3, SqlFieldName = noshow_count ];

Property checkinnum As %Library.Double [ SqlColumnNumber = 4, SqlFieldName = checkin_num ];

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
					set tMe.month = tImporter.%GetData(1)
					set tMe.noshowcount = tImporter.%GetData(2)
					set tMe.checkinnum = tImporter.%GetData(3)
				}
				elseif pSelectMode = 1 {
					set tMe.month = $s('$system.CLS.IsMthd("monthOdbcToLogical"):tImporter.%GetData(1),1:tMe.monthOdbcToLogical(tImporter.%GetData(1)))
					set tMe.noshowcount = $s('$system.CLS.IsMthd("noshowcountOdbcToLogical"):tImporter.%GetData(2),1:tMe.noshowcountOdbcToLogical(tImporter.%GetData(2)))
					set tMe.checkinnum = $s('$system.CLS.IsMthd("checkinnumOdbcToLogical"):tImporter.%GetData(3),1:tMe.checkinnumOdbcToLogical(tImporter.%GetData(3)))
				}
				elseif pSelectMode = 2 {
					set tMe.month = $s('$system.CLS.IsMthd("monthDisplayToLogical"):tImporter.%GetData(1),1:tMe.monthDisplayToLogical(tImporter.%GetData(1)))
					set tMe.noshowcount = $s('$system.CLS.IsMthd("noshowcountDisplayToLogical"):tImporter.%GetData(2),1:tMe.noshowcountDisplayToLogical(tImporter.%GetData(2)))
					set tMe.checkinnum = $s('$system.CLS.IsMthd("checkinnumDisplayToLogical"):tImporter.%GetData(3),1:tMe.checkinnumDisplayToLogical(tImporter.%GetData(3)))
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

Parameter ROWTYPE = "month INTEGER,noshow_count DOUBLE,checkin_num DOUBLE";

Storage Default
{
<Data name="OrdersDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>month</Value>
</Value>
<Value name="3">
<Value>noshowcount</Value>
</Value>
<Value name="4">
<Value>checkinnum</Value>
</Value>
</Data>
<DataLocation>^Data.OrdersD</DataLocation>
<DefaultData>OrdersDefaultData</DefaultData>
<IdLocation>^Data.OrdersD</IdLocation>
<IndexLocation>^Data.OrdersI</IndexLocation>
<StreamLocation>^Data.OrdersS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
