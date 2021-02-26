Class Data.WeekNoshow Extends %Library.Persistent [ Not Abstract, DdlAllowed, Not LegacyInstanceContext, ProcedureBlock ]
{

Property week As %Library.String(MAXLEN = 250) [ SqlColumnNumber = 2 ];

Property noshownum As %Library.Integer(MAXVAL = 2147483647, MINVAL = -2147483648) [ SqlColumnNumber = 3, SqlFieldName = noshow_num ];

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
					set tMe.week = tImporter.%GetData(1)
					set tMe.noshownum = tImporter.%GetData(2)
				}
				elseif pSelectMode = 1 {
					set tMe.week = $s('$system.CLS.IsMthd("weekOdbcToLogical"):tImporter.%GetData(1),1:tMe.weekOdbcToLogical(tImporter.%GetData(1)))
					set tMe.noshownum = $s('$system.CLS.IsMthd("noshownumOdbcToLogical"):tImporter.%GetData(2),1:tMe.noshownumOdbcToLogical(tImporter.%GetData(2)))
				}
				elseif pSelectMode = 2 {
					set tMe.week = $s('$system.CLS.IsMthd("weekDisplayToLogical"):tImporter.%GetData(1),1:tMe.weekDisplayToLogical(tImporter.%GetData(1)))
					set tMe.noshownum = $s('$system.CLS.IsMthd("noshownumDisplayToLogical"):tImporter.%GetData(2),1:tMe.noshownumDisplayToLogical(tImporter.%GetData(2)))
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

Parameter ROWTYPE = "week VARCHAR(250),noshow_num INTEGER";

Storage Default
{
<Data name="WeekNoshowDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>week</Value>
</Value>
<Value name="3">
<Value>noshownum</Value>
</Value>
</Data>
<DataLocation>^Data.WeekNoshowD</DataLocation>
<DefaultData>WeekNoshowDefaultData</DefaultData>
<IdLocation>^Data.WeekNoshowD</IdLocation>
<IndexLocation>^Data.WeekNoshowI</IndexLocation>
<StreamLocation>^Data.WeekNoshowS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
