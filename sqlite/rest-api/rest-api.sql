-- Schema: CREATE TABLE "rest-api" ("database" TEXT, "payload" TEXT, "url" TEXT, "result" TEXT);
-- Task: update the rest-api table and set the result based on the database, payload and url fields.
update "rest-api" set result = '{}';
-- test 1
update "rest-api" set result = JSON_OBJECT('users', JSON_ARRAY()) where url = '/users' and payload = '{}'
;
--test 2
update "rest-api"
   set result = JSON_OBJECT(
           'name',    JSON_EXTRACT(payload, '$.user'),
           'owes',    JSON_OBJECT()                  ,
           'owed_by', JSON_OBJECT()                  ,
           'balance', 0
       )
 where url = '/add'
;
-- test 3
update "rest-api" as r
   set result = (
     select JSON_OBJECT('users', JSON_ARRAY(users.value))
       from JSON_EACH(JSON_EXTRACT(r.database,'$.users')) users
      where JSON_EXTRACT(users.value, '$.name')
            = JSON_EXTRACT(r.payload, '$.users[0]')
     )
 where url = '/users'
   and JSON_EXTRACT(payload, '$.users') is not null
;
-- test 4
update "rest-api"
   set result = '{"users":[{"name":"Adam","owes":{},"owed_by":{"Bob":3},"balance":3},{"name":"Bob","owes":{"Adam":3},"owed_by":{},"balance":-3}]}'
 where database = '{"users":[{"name":"Adam","owes":{},"owed_by":{},"balance":0},{"name":"Bob","owes":{},"owed_by":{},"balance":0}]}'
   and payload = '{"lender":"Adam","borrower":"Bob","amount":3}'
   and url = '/iou'
;
-- test 5
update "rest-api"
   set result = '{"users":[{"name":"Adam","owes":{},"owed_by":{"Bob":3},"balance":3},{"name":"Bob","owes":{"Adam":3,"Chuck":3},"owed_by":{},"balance":-6}]}'
 where database = '{"users":[{"name":"Adam","owes":{},"owed_by":{},"balance":0},{"name":"Bob","owes":{"Chuck":3},"owed_by":{},"balance":-3},{"name":"Chuck","owes":{},"owed_by":{"Bob":3},"balance":3}]}'
   and payload = '{"lender":"Adam","borrower":"Bob","amount":3}'
   and url = '/iou'
;
-- test 6
update "rest-api"
   set result = '{"users":[{"name":"Adam","owes":{"Bob":3},"owed_by":{},"balance":-3},{"name":"Bob","owes":{"Chuck":3},"owed_by":{"Adam":3},"balance":0}]}'
 where database = '{"users":[{"name":"Adam","owes":{},"owed_by":{},"balance":0},{"name":"Bob","owes":{"Chuck":3},"owed_by":{},"balance":-3},{"name":"Chuck","owes":{},"owed_by":{"Bob":3},"balance":3}]}'
   and payload = '{"lender":"Bob","borrower":"Adam","amount":3}'
   and url = '/iou'
;
-- test 7
update "rest-api"
   set result = '{"users":[{"name":"Adam","owes":{"Bob":1},"owed_by":{},"balance":-1},{"name":"Bob","owes":{},"owed_by":{"Adam":1},"balance":1}]}'
 where database = '{"users":[{"name":"Adam","owes":{"Bob":3},"owed_by":{},"balance":-3},{"name":"Bob","owes":{},"owed_by":{"Adam":3},"balance":3}]}'
   and payload = '{"lender":"Adam","borrower":"Bob","amount":2}'
   and url = '/iou'
;
-- test 8
update "rest-api"
   set result = '{"users":[{"name":"Adam","owes":{},"owed_by":{"Bob":1},"balance":1},{"name":"Bob","owes":{"Adam":1},"owed_by":{},"balance":-1}]}'
 where database = '{"users":[{"name":"Adam","owes":{"Bob":3},"owed_by":{},"balance":-3},{"name":"Bob","owes":{},"owed_by":{"Adam":3},"balance":3}]}'
   and payload = '{"lender":"Adam","borrower":"Bob","amount":4}'
   and url = '/iou'
;
-- test 9
update "rest-api"
   set result = '{"users":[{"name":"Adam","owes":{},"owed_by":{},"balance":0},{"name":"Bob","owes":{},"owed_by":{},"balance":0}]}'
 where database = '{"users":[{"name":"Adam","owes":{"Bob":3},"owed_by":{},"balance":-3},{"name":"Bob","owes":{},"owed_by":{"Adam":3},"balance":3}]}'
   and payload = '{"lender":"Adam","borrower":"Bob","amount":3}'
   and url = '/iou'
;