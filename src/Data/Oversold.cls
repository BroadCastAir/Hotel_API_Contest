Class Data.Oversold Extends %Library.Persistent [ Not Abstract, DdlAllowed, Not LegacyInstanceContext, ProcedureBlock ]
{

Property bookingdate As %Library.String [ SqlColumnNumber = 2, SqlFieldName = booking_date ];

Property roomprice As %Library.String [ SqlColumnNumber = 3, SqlFieldName = room_price ];

Property roommax As %Library.Integer(MAXVAL = 2147483647, MINVAL = -2147483648) [ SqlColumnNumber = 4, SqlFieldName = room_max ];

Property unshowfore As %Library.Integer(MAXVAL = 2147483647, MINVAL = -2147483648) [ SqlColumnNumber = 5, SqlFieldName = unshow_fore ];

Property resultMax As %Library.String [ SqlColumnNumber = 6 ];

Property resultMaxsold As %Library.Integer(MAXVAL = 2147483647, MINVAL = -2147483648) [ SqlColumnNumber = 7, SqlFieldName = resultMax_sold ];

Property arrivalrate As %Library.String [ SqlColumnNumber = 8, SqlFieldName = arrival_rate ];

Property arrivalratefore As %Library.String [ SqlColumnNumber = 9, SqlFieldName = arrival_rate_fore ];

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
					set tMe.bookingdate = tImporter.%GetData(1)
					set tMe.roomprice = tImporter.%GetData(2)
					set tMe.roommax = tImporter.%GetData(3)
					set tMe.unshowfore = tImporter.%GetData(4)
					set tMe.resultMax = tImporter.%GetData(5)
					set tMe.resultMaxsold = tImporter.%GetData(6)
					set tMe.arrivalrate = tImporter.%GetData(7)
					set tMe.arrivalratefore = tImporter.%GetData(8)
				}
				elseif pSelectMode = 1 {
					set tMe.bookingdate = $s('$system.CLS.IsMthd("bookingdateOdbcToLogical"):tImporter.%GetData(1),1:tMe.bookingdateOdbcToLogical(tImporter.%GetData(1)))
					set tMe.roomprice = $s('$system.CLS.IsMthd("roompriceOdbcToLogical"):tImporter.%GetData(2),1:tMe.roompriceOdbcToLogical(tImporter.%GetData(2)))
					set tMe.roommax = $s('$system.CLS.IsMthd("roommaxOdbcToLogical"):tImporter.%GetData(3),1:tMe.roommaxOdbcToLogical(tImporter.%GetData(3)))
					set tMe.unshowfore = $s('$system.CLS.IsMthd("unshowforeOdbcToLogical"):tImporter.%GetData(4),1:tMe.unshowforeOdbcToLogical(tImporter.%GetData(4)))
					set tMe.resultMax = $s('$system.CLS.IsMthd("resultMaxOdbcToLogical"):tImporter.%GetData(5),1:tMe.resultMaxOdbcToLogical(tImporter.%GetData(5)))
					set tMe.resultMaxsold = $s('$system.CLS.IsMthd("resultMaxsoldOdbcToLogical"):tImporter.%GetData(6),1:tMe.resultMaxsoldOdbcToLogical(tImporter.%GetData(6)))
					set tMe.arrivalrate = $s('$system.CLS.IsMthd("arrivalrateOdbcToLogical"):tImporter.%GetData(7),1:tMe.arrivalrateOdbcToLogical(tImporter.%GetData(7)))
					set tMe.arrivalratefore = $s('$system.CLS.IsMthd("arrivalrateforeOdbcToLogical"):tImporter.%GetData(8),1:tMe.arrivalrateforeOdbcToLogical(tImporter.%GetData(8)))
				}
				elseif pSelectMode = 2 {
					set tMe.bookingdate = $s('$system.CLS.IsMthd("bookingdateDisplayToLogical"):tImporter.%GetData(1),1:tMe.bookingdateDisplayToLogical(tImporter.%GetData(1)))
					set tMe.roomprice = $s('$system.CLS.IsMthd("roompriceDisplayToLogical"):tImporter.%GetData(2),1:tMe.roompriceDisplayToLogical(tImporter.%GetData(2)))
					set tMe.roommax = $s('$system.CLS.IsMthd("roommaxDisplayToLogical"):tImporter.%GetData(3),1:tMe.roommaxDisplayToLogical(tImporter.%GetData(3)))
					set tMe.unshowfore = $s('$system.CLS.IsMthd("unshowforeDisplayToLogical"):tImporter.%GetData(4),1:tMe.unshowforeDisplayToLogical(tImporter.%GetData(4)))
					set tMe.resultMax = $s('$system.CLS.IsMthd("resultMaxDisplayToLogical"):tImporter.%GetData(5),1:tMe.resultMaxDisplayToLogical(tImporter.%GetData(5)))
					set tMe.resultMaxsold = $s('$system.CLS.IsMthd("resultMaxsoldDisplayToLogical"):tImporter.%GetData(6),1:tMe.resultMaxsoldDisplayToLogical(tImporter.%GetData(6)))
					set tMe.arrivalrate = $s('$system.CLS.IsMthd("arrivalrateDisplayToLogical"):tImporter.%GetData(7),1:tMe.arrivalrateDisplayToLogical(tImporter.%GetData(7)))
					set tMe.arrivalratefore = $s('$system.CLS.IsMthd("arrivalrateforeDisplayToLogical"):tImporter.%GetData(8),1:tMe.arrivalrateforeDisplayToLogical(tImporter.%GetData(8)))
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

Parameter ROWTYPE = "booking_date DATE,room_price MONEY,room_max INTEGER,unshow_fore INTEGER,resultMax MONEY,resultMax_sold INTEGER,arrival_rate MONEY,arrival_rate_fore MONEY";

Storage Default
{
<Data name="OversoldDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>bookingdate</Value>
</Value>
<Value name="3">
<Value>roomprice</Value>
</Value>
<Value name="4">
<Value>roommax</Value>
</Value>
<Value name="5">
<Value>unshowfore</Value>
</Value>
<Value name="6">
<Value>resultMax</Value>
</Value>
<Value name="7">
<Value>resultMaxsold</Value>
</Value>
<Value name="8">
<Value>arrivalrate</Value>
</Value>
<Value name="9">
<Value>arrivalratefore</Value>
</Value>
</Data>
<DataLocation>^Data.OversoldD</DataLocation>
<DefaultData>OversoldDefaultData</DefaultData>
<IdLocation>^Data.OversoldD</IdLocation>
<IndexLocation>^Data.OversoldI</IndexLocation>
<StreamLocation>^Data.OversoldS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
