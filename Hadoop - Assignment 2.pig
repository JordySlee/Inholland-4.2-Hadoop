ordersCSV = LOAD '/user/maria_dev/diplomacy/orders.csv'
USING PigStorage(',') AS
(game_id:chararray,
unit_id:chararray,
unit_order:chararray,
location:chararray,
target:chararray,
target_dest:chararray,
success:chararray,
reason:chararray,
turn_num:chararray);

Filtered = FILTER ordersCSV BY target == '"Holland"';

Grouped = GROUP Filtered BY (location, target);

Counted = FOREACH Grouped GENERATE group, COUNT(Filtered);

Ordered = ORDER Counted BY $0 ASC;

DUMP Ordered;