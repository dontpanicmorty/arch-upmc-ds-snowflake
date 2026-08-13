CREATE OR REPLACE VIEW DWOAO.AvalonRequestPayloadDetail AS
SELECT A.* FROM CDC_Merge.dbo.AvalonRequestPayloadDetail A INNER JOIN
				CDC_Merge.dbo.AvalonRequestPayload1Header B ON A.RequestPayload1Id=B.RowId AND B.TPACLIENT = '000001' AND B.TPADIVISION = '0001' AND B.TPAIDOFCLIENT = '000001'
;
