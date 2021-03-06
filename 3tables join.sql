1 table

|   tel_no    |   client_no   |
|-------------|---------------|
| 01011111234 |   aa011234    |
| 01022221234 |   aa021234    |
2 table

| client_no | client_name |
|-----------|-------------|
|   1234    | kim         | 
3 table

| client_no | client_name |
|   1234    | wa          |
I want to:

If the front of client_no of 1table starts with aa01, the client_name of 2table will be changed.
If the front of client_no of 1table starts with aa02, the client_name of 3table will be changed.
Expected result:

|   tel_no    |  client_no | client_name |
|-------------|------------|-------------|
| 01011111234 |  aa011234  | kim         |
| 01022221234 | aa021234   | wa          |

--------------------------------------------------------------------------
--------------------------------------------------------------------------

Sample data:

SQL> with
  2  t1 (tel_no, client_no) as
  3    (select '01011111234', 'aa011234' from dual union all
  4     select '01022221234', 'aa021234' from dual
  5    ),
  6  t2 (client_no, client_name) as
  7    (select '1234', 'kim' from dual),
  8  t3 (client_no, client_name) as
  9    (select '1234', 'wa'  from dual)
 10  --
Query:

 11  select a.tel_no, a.client_no,
 12    case when substr(a.client_no, 1, 4) = 'aa01' then b.client_name
 13         when substr(a.client_no, 1, 4) = 'aa02' then c.client_name
 14    end client_name
 15  from t1 a join t2 b on substr(a.client_no, 5) = b.client_no
 16            join t3 c on substr(a.client_no, 5) = c.client_no;

TEL_NO      CLIENT_N CLI
----------- -------- ---
01011111234 aa011234 kim
01022221234 aa021234 wa

SQL>

--------------------------------------------------------------------------
--------------------------------------------------------------------------

SELECT tel_no, t1.client_no, client_name 
FROM t1 JOIN t2 
ON t1.client_no = CONCAT('aa01',t2.client_no)
UNION ALL
SELECT tel_no, t1.client_no, client_name 
FROM t1 JOIN t3 
ON t1.client_no = CONCAT('aa02',t3.client_no);

--------------------------------------------------------------------------
--------------------------------------------------------------------------

SELECT A.????????????
     , A.????????????
     , DECODE(SUBSTR(A.????????????,1,4),'aa01',B.????????????,C.????????????) as ????????????
FROM   TABLE01 A
     , TABLE02 B
     , TABLE03 C
WHERE A.???????????? LIKE '%'||B.????????????(+) 
AND   A.???????????? LIKE '%'||C.????????????(+)
