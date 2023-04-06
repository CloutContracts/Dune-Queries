WITH Eth_address AS
  (SELECT DATE_TRUNC('day', evt_block_time) AS DAY,
          COUNT(DISTINCT "to") AS Unique_Wallets,
          COUNT(DISTINCT "to") * 100.0 / LAG(COUNT(DISTINCT "to")) OVER (
                                                                         ORDER BY DATE_TRUNC('day', evt_block_time)) - 100 AS Growth_Overtime
   FROM erc20_ethereum.evt_transfer t
   WHERE contract_address IN (0x1da4858ad385cc377165A298CC2CE3fce0C5fD31 , 0xf79deaBc1406a3AD07c70877fBaEb90777B77E68)
   GROUP BY evt_block_time),
     Bnb_address AS
  (SELECT DATE_TRUNC('day', evt_block_time) AS DAY,
          COUNT(DISTINCT "to") AS Unique_Wallets,
          COUNT(DISTINCT "to") * 100.0 / LAG(COUNT(DISTINCT "to")) OVER (
                                                                         ORDER BY DATE_TRUNC('day', evt_block_time)) - 100 AS Growth_Overtime
   FROM erc20_bnb.evt_Transfer t
   WHERE contract_address = 0x3e3B357061103DC040759aC7DceEaba9901043aD
   GROUP BY evt_block_time),
     Gnosis_address AS
  (SELECT DATE_TRUNC('day', evt_block_time) AS DAY,
          COUNT(DISTINCT "to") AS Unique_Wallets,
          COUNT(DISTINCT "to") * 100.0 / LAG(COUNT(DISTINCT "to")) OVER (
                                                                         ORDER BY DATE_TRUNC('day', evt_block_time)) - 100 AS Growth_Overtime
   FROM erc20_gnosis.evt_Transfer t
   WHERE contract_address = 0xcC9D34a7bE0c8B11e8390cce0B4b46a1b268Aaa7
   GROUP BY evt_block_time),
     Polygon_address AS
  (SELECT DATE_TRUNC('day', evt_block_time) AS DAY,
          COUNT(DISTINCT "to") AS Unique_Wallets,
          COUNT(DISTINCT "to") * 100.0 / LAG(COUNT(DISTINCT "to")) OVER (
                                                                         ORDER BY DATE_TRUNC('day', evt_block_time)) - 100 AS Growth_Overtime
   FROM erc20_polygon.evt_Transfer t
   WHERE contract_address = 0xe346502D3BB39262EE2d9D2C52c7aE7C1f98E7e8
   GROUP BY evt_block_time),
     Iotex_address AS
  (SELECT DATE_TRUNC('day', evt_block_time) AS DAY,
          COUNT(DISTINCT "to") AS Unique_Wallets,
          COUNT(DISTINCT "to") * 100.0 / LAG(COUNT(DISTINCT "to")) OVER (
                                                                         ORDER BY DATE_TRUNC('day', evt_block_time)) - 100 AS Growth_Overtime
   FROM iotex_ethereum.IoTeXNetwork_evt_Transfer t
   WHERE contract_address = 0x6f7320e66c89F512b5c7307e1f60A21D5297E0A1
   GROUP BY evt_block_time)
SELECT DAY,
       SUM(Unique_Wallets) AS Total_Users_Per_Day,
       SUM(Growth_Overtime) AS Total_Growth_Overtime
FROM
  (SELECT *
   FROM Eth_address
   UNION ALL SELECT *
   FROM Bnb_address
   UNION ALL SELECT *
   FROM Gnosis_address
   UNION ALL SELECT *
   FROM Polygon_address
   UNION ALL SELECT *
   FROM Iotex_address) subquery
GROUP BY DAY
ORDER BY DAY ASC;
