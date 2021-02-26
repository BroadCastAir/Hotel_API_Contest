Class Data.NoshowFore Extends %Library.Persistent [ Not Abstract, DdlAllowed, Not LegacyInstanceContext, ProcedureBlock ]
{

Property datefore As %Library.String [ SqlColumnNumber = 2, SqlFieldName = date_fore ];

Property roomnum As %Library.Integer(MAXVAL = 2147483647, MINVAL = -2147483648) [ SqlColumnNumber = 3, SqlFieldName = room_num ];

Property resultMaxsold As %Library.Integer(MAXVAL = 2147483647, MINVAL = -2147483648) [ SqlColumnNumber = 4, SqlFieldName = resultMax_sold ];

Property oversoldnum As %Library.Integer(MAXVAL = 2147483647, MINVAL = -2147483648) [ SqlColumnNumber = 5, SqlFieldName = oversold_num ];

Property offline As %Library.Integer(MAXVAL = 2147483647, MINVAL = -2147483648) [ SqlColumnNumber = 6 ];

Property online As %Library.Integer(MAXVAL = 2147483647, MINVAL = -2147483648) [ SqlColumnNumber = 7 ];

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
					set tMe.datefore = tImporter.%GetData(1)
					set tMe.roomnum = tImporter.%GetData(2)
					set tMe.resultMaxsold = tImporter.%GetData(3)
					set tMe.oversoldnum = tImporter.%GetData(4)
					set tMe.offline = tImporter.%GetData(5)
					set tMe.online = tImporter.%GetData(6)
				}
				elseif pSelectMode = 1 {
					set tMe.datefore = $s('$system.CLS.IsMthd("dateforeOdbcToLogical"):tImporter.%GetData(1),1:tMe.dateforeOdbcToLogical(tImporter.%GetData(1)))
					set tMe.roomnum = $s('$system.CLS.IsMthd("roomnumOdbcToLogical"):tImporter.%GetData(2),1:tMe.roomnumOdbcToLogical(tImporter.%GetData(2)))
					set tMe.resultMaxsold = $s('$system.CLS.IsMthd("resultMaxsoldOdbcToLogical"):tImporter.%GetData(3),1:tMe.resultMaxsoldOdbcToLogical(tImporter.%GetData(3)))
					set tMe.oversoldnum = $s('$system.CLS.IsMthd("oversoldnumOdbcToLogical"):tImporter.%GetData(4),1:tMe.oversoldnumOdbcToLogical(tImporter.%GetData(4)))
					set tMe.offline = $s('$system.CLS.IsMthd("offlineOdbcToLogical"):tImporter.%GetData(5),1:tMe.offlineOdbcToLogical(tImporter.%GetData(5)))
					set tMe.online = $s('$system.CLS.IsMthd("onlineOdbcToLogical"):tImporter.%GetData(6),1:tMe.onlineOdbcToLogical(tImporter.%GetData(6)))
				}
				elseif pSelectMode = 2 {
					set tMe.datefore = $s('$system.CLS.IsMthd("dateforeDisplayToLogical"):tImporter.%GetData(1),1:tMe.dateforeDisplayToLogical(tImporter.%GetData(1)))
					set tMe.roomnum = $s('$system.CLS.IsMthd("roomnumDisplayToLogical"):tImporter.%GetData(2),1:tMe.roomnumDisplayToLogical(tImporter.%GetData(2)))
					set tMe.resultMaxsold = $s('$system.CLS.IsMthd("resultMaxsoldDisplayToLogical"):tImporter.%GetData(3),1:tMe.resultMaxsoldDisplayToLogical(tImporter.%GetData(3)))
					set tMe.oversoldnum = $s('$system.CLS.IsMthd("oversoldnumDisplayToLogical"):tImporter.%GetData(4),1:tMe.oversoldnumDisplayToLogical(tImporter.%GetData(4)))
					set tMe.offline = $s('$system.CLS.IsMthd("offlineDisplayToLogical"):tImporter.%GetData(5),1:tMe.offlineDisplayToLogical(tImporter.%GetData(5)))
					set tMe.online = $s('$system.CLS.IsMthd("onlineDisplayToLogical"):tImporter.%GetData(6),1:tMe.onlineDisplayToLogical(tImporter.%GetData(6)))
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

Parameter ROWTYPE = "date_fore DATE,room_num INTEGER,resultMax_sold INTEGER,oversold_num INTEGER,offline INTEGER,online INTEGER";

Storage Default
{
<Data name="NoshowForeDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>datefore</Value>
</Value>
<Value name="3">
<Value>roomnum</Value>
</Value>
<Value name="4">
<Value>resultMaxsold</Value>
</Value>
<Value name="5">
<Value>oversoldnum</Value>
</Value>
<Value name="6">
<Value>offline</Value>
</Value>
<Value name="7">
<Value>online</Value>
</Value>
</Data>
<DataLocation>^Data.NoshowForeD</DataLocation>
<DefaultData>NoshowForeDefaultData</DefaultData>
<IdLocation>^Data.NoshowForeD</IdLocation>
<IndexLocation>^Data.NoshowForeI</IndexLocation>
<StreamLocation>^Data.NoshowForeS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
