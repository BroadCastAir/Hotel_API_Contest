Class Data.PriceTrend Extends %Library.Persistent [ Not Abstract, DdlAllowed, Not LegacyInstanceContext, ProcedureBlock ]
{

Property date As %Library.String [ SqlColumnNumber = 2 ];

Property uncancelednum As %Library.Integer(MAXVAL = 2147483647, MINVAL = -2147483648) [ SqlColumnNumber = 3, SqlFieldName = uncanceled_num ];

Property roomprice As %Library.String(MAXLEN = 250) [ SqlColumnNumber = 4, SqlFieldName = room_price ];

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
					set tMe.date = tImporter.%GetData(1)
					set tMe.uncancelednum = tImporter.%GetData(2)
					set tMe.roomprice = tImporter.%GetData(3)
				}
				elseif pSelectMode = 1 {
					set tMe.date = $s('$system.CLS.IsMthd("dateOdbcToLogical"):tImporter.%GetData(1),1:tMe.dateOdbcToLogical(tImporter.%GetData(1)))
					set tMe.uncancelednum = $s('$system.CLS.IsMthd("uncancelednumOdbcToLogical"):tImporter.%GetData(2),1:tMe.uncancelednumOdbcToLogical(tImporter.%GetData(2)))
					set tMe.roomprice = $s('$system.CLS.IsMthd("roompriceOdbcToLogical"):tImporter.%GetData(3),1:tMe.roompriceOdbcToLogical(tImporter.%GetData(3)))
				}
				elseif pSelectMode = 2 {
					set tMe.date = $s('$system.CLS.IsMthd("dateDisplayToLogical"):tImporter.%GetData(1),1:tMe.dateDisplayToLogical(tImporter.%GetData(1)))
					set tMe.uncancelednum = $s('$system.CLS.IsMthd("uncancelednumDisplayToLogical"):tImporter.%GetData(2),1:tMe.uncancelednumDisplayToLogical(tImporter.%GetData(2)))
					set tMe.roomprice = $s('$system.CLS.IsMthd("roompriceDisplayToLogical"):tImporter.%GetData(3),1:tMe.roompriceDisplayToLogical(tImporter.%GetData(3)))
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

Parameter ROWTYPE = "date DATE,uncanceled_num INTEGER,room_price VARCHAR(250)";

Storage Default
{
<Data name="PriceTrendDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>date</Value>
</Value>
<Value name="3">
<Value>uncancelednum</Value>
</Value>
<Value name="4">
<Value>roomprice</Value>
</Value>
</Data>
<DataLocation>^Data.PriceTrendD</DataLocation>
<DefaultData>PriceTrendDefaultData</DefaultData>
<IdLocation>^Data.PriceTrendD</IdLocation>
<IndexLocation>^Data.PriceTrendI</IndexLocation>
<StreamLocation>^Data.PriceTrendS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
