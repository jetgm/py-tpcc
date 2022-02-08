create database if not exists tpcc;
use tpcc;

CREATE TABLE if not exists WAREHOUSE (
  W_ID Int16 DEFAULT 0,
  W_NAME Nullable(String),
  W_STREET_1 Nullable(String),
  W_STREET_2 Nullable(String),
  W_CITY Nullable(String),
  W_STATE Nullable(String),
  W_ZIP Nullable(String),
  W_TAX Nullable(Float64),
  W_YTD Nullable(Float64)
)
  ENGINE = MergeTree
  ORDER BY(W_ID)
;

CREATE TABLE if not exists  DISTRICT
(
    D_ID        Int8  DEFAULT 0,
    D_W_ID      Int16 DEFAULT 0,
    D_NAME      Nullable(String),
    D_STREET_1  Nullable(String),
    D_STREET_2  Nullable(String),
    D_CITY      Nullable(String),
    D_STATE     Nullable(String),
    D_ZIP       Nullable(String),
    D_TAX       Nullable(Float64),
    D_YTD       Nullable(Float64),
    D_NEXT_O_ID Nullable(Int32)
)
  ENGINE = MergeTree
  ORDER BY(D_W_ID,D_ID)
;

CREATE TABLE if not exists ITEM (
  I_ID Int32 DEFAULT 0,
  I_IM_ID Nullable(Int32) DEFAULT NULL,
  I_NAME Nullable(String) DEFAULT NULL,
  I_PRICE Nullable(Float64) DEFAULT NULL,
  I_DATA Nullable(String) DEFAULT NULL
)
    ENGINE = MergeTree
    ORDER BY(I_ID)
;

CREATE TABLE if not exists CUSTOMER
(
    C_ID           Int32    DEFAULT 0,
    C_D_ID         Int8     DEFAULT 0,
    C_W_ID         Int16    DEFAULT 0,
    C_FIRST        Nullable(String),
    C_MIDDLE       Nullable(String),
    C_LAST         Nullable(String),
    C_STREET_1     Nullable(String),
    C_STREET_2     Nullable(String),
    C_CITY         Nullable(String),
    C_STATE        Nullable(String),
    C_ZIP          Nullable(String),
    C_PHONE        Nullable(String),
    C_SINCE        DateTime DEFAULT now(),
    C_CREDIT       Nullable(String),
    C_CREDIT_LIM   Nullable(Float64),
    C_DISCOUNT     Nullable(Float64),
    C_BALANCE      Nullable(Float64),
    C_YTD_PAYMENT  Nullable(Float64),
    C_PAYMENT_CNT  Nullable(Int32)   DEFAULT NULL,
    C_DELIVERY_CNT Nullable(Int32)   DEFAULT NULL,
    C_DATA         String
)
  ENGINE = MergeTree
  ORDER BY(C_W_ID,C_D_ID,C_ID)
;


CREATE TABLE if not exists HISTORY (
  H_C_ID Int32 default 0,
  H_C_D_ID Nullable(Int8),
  H_C_W_ID Nullable(Int16),
  H_D_ID Nullable(Int8),
  H_W_ID Int16 DEFAULT 0,
  H_DATE DateTime DEFAULT now(),
  H_AMOUNT Nullable(Float64),
  H_DATA Nullable(String)
)
  ENGINE = MergeTree
  ORDER BY(H_C_ID)
  partition by toYYYYMM(H_DATE)
;


CREATE TABLE if not exists STOCK (
  S_I_ID Int32 DEFAULT 0,
  S_W_ID Int16 DEFAULT 0,
  S_QUANTITY Int32 DEFAULT 0,
  S_DIST_01 Nullable(String),
  S_DIST_02 Nullable(String),
  S_DIST_03 Nullable(String),
  S_DIST_04 Nullable(String),
  S_DIST_05 Nullable(String),
  S_DIST_06 Nullable(String),
  S_DIST_07 Nullable(String),
  S_DIST_08 Nullable(String),
  S_DIST_09 Nullable(String),
  S_DIST_10 Nullable(String),
  S_YTD Nullable(Int32),
  S_ORDER_CNT Nullable(Int32),
  S_REMOTE_CNT Nullable(Int32),
  S_DATA Nullable(String)
)
  ENGINE = MergeTree
  ORDER BY(S_W_ID,S_I_ID)
;

CREATE TABLE if not exists ORDERS (
  O_ID Int32 DEFAULT 0,
  O_C_ID Nullable(Int32),
  O_D_ID Int8 DEFAULT 0,
  O_W_ID Int16 DEFAULT 0,
  O_ENTRY_D DateTime DEFAULT now(),
  O_CARRIER_ID Nullable(Int32),
  O_OL_CNT Nullable(Int32),
  O_ALL_LOCAL Nullable(Int32)
)
  ENGINE = MergeTree
  ORDER BY(O_W_ID,O_D_ID,O_ID)
partition by toYYYYMM(O_ENTRY_D)
;

CREATE TABLE if not exists NEW_ORDER (
  NO_O_ID Int32 DEFAULT 0,
  NO_D_ID Int8 DEFAULT 0,
  NO_W_ID Int16 DEFAULT 0
)
 ENGINE = MergeTree
  ORDER BY(NO_O_ID)
;

CREATE TABLE if not exists ORDER_LINE (
  OL_O_ID Int32 DEFAULT 0,
  OL_D_ID Int8 DEFAULT 0,
  OL_W_ID Int16 DEFAULT 0,
  OL_NUMBER Int32 DEFAULT 0,
  OL_I_ID Nullable(Int32),
  OL_SUPPLY_W_ID Nullable(Int16),
  OL_DELIVERY_D Nullable(DateTime),
  OL_QUANTITY Nullable(Int32),
  OL_AMOUNT Nullable(Float64),
  OL_DIST_INFO Nullable(String)
)
 ENGINE = MergeTree
  ORDER BY(OL_W_ID,OL_D_ID,OL_O_ID)
;
