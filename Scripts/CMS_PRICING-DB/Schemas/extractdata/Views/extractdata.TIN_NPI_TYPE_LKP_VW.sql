
--A view to delcare the NPI_TYPE for each NPI associated with a GROUP_TIN. 
--Use GROUP_TIN and NPI to determine the TYPE, as the NPI_TYPE will vary depending on the TIN
--An NPI may be used by many TIN, and depending on the TIN the NPI_TYPE may be different
CREATE OR REPLACE VIEW EXTRACTDATA.TIN_NPI_TYPE_LKP_VW
AS
(
select Distinct GROUP_TIN, NPI, NPI_TYPE from stagedata.provider_networks_vw
);
