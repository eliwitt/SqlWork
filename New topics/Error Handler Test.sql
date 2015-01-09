EXEC [dbo].[pSimpleDivideToTestErrorLogging] 
  @Numerator = 1 
, @Denominator = 0
, @LogError = 1
, @Debug = 1;

select * from SPErrorLog