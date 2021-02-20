--############ Exercícios obtidos em https://pgexercises.com/ ############

--############ BASIC ############

--How can you retrieve all the information from the cd.facilities table?
SELECT * FROM cd.facilities;

--How can you produce a list of facilities that charge a fee to members?
SELECT * FROM cd.facilities WHERE membercost > 0;

--How can you produce a list of facilities that charge a fee to members, and that fee is less than 1/50th of 
--the monthly maintenance cost? Return the facid, facility name, member cost, and monthly maintenance of the facilities in question.
SELECT facid, name, membercost, monthlymaintenance FROM cd.facilities
WHERE membercost > 0 AND membercost < monthlymaintenance * 1 / 50;

--How can you produce a list of all facilities with the word 'Tennis' in their name?
SELECT * FROM cd.facilities WHERE name LIKE '%Tennis%';

--How can you retrieve the details of facilities with ID 1 and 5? Try to do it without using the OR operator.
SELECT * FROM cd.facilities WHERE facid = 1 OR facid = 5;

--How can you produce a list of facilities, with each labelled as 'cheap' or 'expensive' depending on if their monthly 
--maintenance cost is more than $100? Return the name and monthly maintenance of the facilities in question.
SELECT name, 
CASE WHEN (monthlymaintenance > 100) THEN 'expensive' 	
ELSE 'cheap' 
END AS cost 
FROM cd.facilities;

--How can you produce a list of members who joined after the start of September 2012? Return the memid, surname, firstname, 
--and joindate of the members in question.
SELECT memid, surname, firstname, joindate FROM cd.members WHERE joindate >= '2012-09-01';

--How can you produce an ordered list of the first 10 surnames in the members table? The list must not contain duplicates.
SELECT DISTINCT surname FROM cd.members
ORDER BY surname LIMIT 10;

--You, for some reason, want a combined list of all surnames and all facility names. Yes, this is a contrived example :-). 
--Produce that list!
SELECT surname FROM cd.members
UNION 
SELECT name FROM cd.facilities;

--You'd like to get the signup date of your last member. How can you retrieve this information?
SELECT joindate AS latest FROM cd.members ORDER BY joindate DESC FETCH FIRST ROW ONLY;

--You'd like to get the first and last name of the last member(s) who signed up - not just the date. How can you do that?
SELECT firstname, surname, joindate FROM cd.members ORDER BY joindate DESC FETCH FIRST ROW ONLY;

--############ JOINS AND SUBQUERIES ############

--How can you produce a list of the start times for bookings by members named 'David Farrell'?
SELECT starttime FROM cd.bookings
JOIN cd.members ON (cd.members.memid = cd.bookings.memid)
WHERE cd.members.firstname = 'David' AND cd.members.surname = 'Farrell';

--How can you produce a list of the start times for bookings for tennis courts, for the date '2012-09-21'? 
--Return a list of start time and facility name pairings, ordered by the time.
SELECT bk.starttime AS start,
fc.name FROM cd.bookings bk
JOIN cd.facilities fc
ON bk.facid = fc.facid
WHERE fc.name LIKE 'Tennis Court%'
AND bk.starttime BETWEEN '2012-09-21 00:00:00' AND '2012-09-21 23:59:59';

--How can you output a list of all members, including the individual who recommended them (if any)? 
--Ensure that results are ordered by (surname, firstname).
SELECT mb1.firstname AS memfname, 
mb1.surname AS memsname, mb2.firstname AS recfname, 
mb2.surname AS recsname 
FROM cd.members mb1
LEFT OUTER JOIN cd.members mb2 ON mb2.memid = mb1.recommendedby
ORDER BY memsname, memfname;

--How can you produce a list of all members who have used a tennis court? Include in your output the name of the court, 
--and the name of the member formatted as a single column. Ensure no duplicate data, and order by the member name followed 
--by the facility name.
SELECT DISTINCT mb.firstname || ' ' || mb.surname AS member, fc.name AS facility
FROM cd.members AS mb
JOIN cd.bookings AS bk
ON mb.memid = bk.memid
JOIN cd.facilities AS fc
ON bk.facid = fc.facid
WHERE fc.name LIKE 'Tennis Court%'
ORDER BY member, facility;

--How can you output a list of all members, including the individual who recommended them (if any), without using any joins? 
--Ensure that there are no duplicates in the list, and that each firstname + surname pairing is formatted as a column and ordered.
SELECT DISTINCT mb.firstname || ' ' || mb.surname AS member, 
(SELECT rc.firstname || ' ' || rc.surname AS recommender 
 FROM cd.members rc WHERE rc.memid = mb.recommendedby)
FROM cd.members mb
ORDER BY member;

--The Produce a list of costly bookings exercise contained some messy logic: we had to calculate the booking cost in both 
--the WHERE clause and the CASE statement. Try to simplify this calculation using subqueries. For reference, the question was:
--How can you produce a list of bookings on the day of 2012-09-14 which will cost the member (or guest) more than $30? 
--Remember that guests have different costs to members (the listed costs are per half-hour 'slot'), and the guest user is 
--always ID 0. Include in your output the name of the facility, the name of the member formatted as a single column, and the cost. 
--Order by descending cost.
SELECT member, facility, cost FROM (
	SELECT mb.firstname || ' ' || mb.surname AS member, fc.name AS facility,
	CASE WHEN mb.memid = 0 THEN bk.slots*fc.guestcost
	ELSE bk.slots*fc.membercost
	END AS cost
	FROM cd.members mb
	JOIN cd.bookings bk ON mb.memid = bk.memid
	JOIN cd.facilities fc ON fc.facid = bk.facid
	WHERE bk.starttime > '2012-09-14' AND bk.starttime < '2012-09-15') AS booking
WHERE cost > 30
ORDER BY cost DESC;

--############ MODIFYING DATA ############

--In the previous exercise, you learned how to add a facility. Now you're going to add multiple facilities in one command. 
--Use the following values:
--facid: 9, Name: 'Spa', membercost: 20, guestcost: 30, initialoutlay: 100000, monthlymaintenance: 800.
--facid: 10, Name: 'Squash Court 2', membercost: 3.5, guestcost: 17.5, initialoutlay: 5000, monthlymaintenance: 80.
INSERT INTO cd.facilities (facid, name, membercost, guestcost, initialoutlay, monthlymaintenance)
VALUES (9, 'Spa', 20, 30, 100000, 800),
(10, 'Squash Court 2', 3.5, 17.5, 5000, 80);

--Let's try adding the spa to the facilities table again. This time, though, we want to automatically generate the value for 
--the next facid, rather than specifying it as a constant. Use the following values for everything else:
--Name: 'Spa', membercost: 20, guestcost: 30, initialoutlay: 100000, monthlymaintenance: 800.
INSERT INTO cd.facilities (facid, name, membercost, guestcost, initialoutlay, monthlymaintenance)
VALUES ((SELECT fc.facid + 1 FROM cd.facilities fc ORDER BY fc.facid DESC LIMIT 1),'Spa', 20, 30, 100000, 800);

--We want to increase the price of the tennis courts for both members and guests. Update the costs to be 6 for members, and 
--30 for guests.
UPDATE cd.facilities SET membercost = 6, guestcost = 30
WHERE name LIKE 'Tennis Court%';

--We want to alter the price of the second tennis court so that it costs 10% more than the first one. Try to do this without 
--using constant values for the prices, so that we can reuse the statement if we want to.
UPDATE cd.facilities fc SET membercost = (SELECT membercost * 1.1 FROM cd.facilities fc WHERE fc.facid = 0), 
guestcost = (SELECT guestcost * 1.1 FROM cd.facilities fc WHERE fc.facid = 0)
WHERE fc.facid = 1;

--As part of a clearout of our database, we want to delete all bookings from the cd.bookings table. How can we accomplish this?
DELETE FROM cd.bookings;

--We want to remove member 37, who has never made a booking, from our database. How can we achieve that?
DELETE FROM cd.members mb WHERE mb.memid = 37;

--In our previous exercises, we deleted a specific member who had never made a booking. How can we make that more general, 
--to delete all members who have never made a booking?
DELETE FROM cd.members mb WHERE memid NOT IN (SELECT bk.memid FROM cd.bookings bk);

--############ AGGREGATION ############

--Produce a count of the number of facilities that have a cost to guests of 10 or more.
SELECT COUNT(guestcost) FROM cd.facilities
WHERE guestcost >= 10;

--Produce a count of the number of recommendations each member has made. Order by member ID.
SELECT recommendedby, COUNT (recommendedby) FROM cd.members
WHERE recommendedby IS NOT NULL
GROUP BY recommendedby
ORDER BY recommendedby;

--Produce a list of the total number of slots booked per facility per month in the year of 2012. Produce an output 
--table consisting of facility id and slots, sorted by the id and month.
SELECT facid, EXTRACT(MONTH FROM starttime) AS month, SUM(slots) AS "Total Slots" 
FROM cd.bookings
WHERE EXTRACT(YEAR FROM starttime) = 2012
GROUP BY facid, month
ORDER BY facid, month;

--Find the total number of members (including guests) who have made at least one booking.
SELECT COUNT (DISTINCT memid) FROM cd.bookings;

--Produce a list of facilities with more than 1000 slots booked. Produce an output table consisting of facility id and slots, 
--sorted by facility id.
SELECT facid, SUM(slots) AS "Total Slots" FROM cd.bookings
GROUP BY facid
HAVING SUM(slots) > 1000
ORDER BY facid;

--Output the facility id that has the highest number of slots booked. For bonus points, try a version without a LIMIT clause. 
--This version will probably look messy!
SELECT facid, SUM(slots) AS "Total Slots" FROM cd.bookings
GROUP BY facid
ORDER BY "Total Slots" DESC
LIMIT 1;

--Produce a list of the total number of hours booked per facility, remembering that a slot lasts half an hour. 
--The output table should consist of the facility id, name, and hours booked, sorted by facility id. Try formatting the 
--hours to two decimal places.
SELECT fc.facid, fc.name, TRUNC(SUM(bk.slots)*0.5, 2) AS "Total Hours" FROM cd.facilities fc
JOIN cd.bookings bk ON bk.facid = fc.facid
GROUP BY fc.facid
ORDER BY facid;

--############ DATE ############

--Produce a timestamp for 1 a.m. on the 31st of August 2012.
SELECT timestamp '2012-08-31 01:00:00'; 

--Find the result of subtracting the timestamp '2012-07-30 01:00:00' from the timestamp '2012-08-31 01:00:00'
SELECT timestamp '2012-08-31 01:00:00' - timestamp '2012-07-30 01:00:00' AS interval;

--Produce a list of all the dates in October 2012. They can be output as a timestamp (with time set to midnight) or a date.
SELECT generate_series(timestamp '2012-10-01 00:00:00', timestamp '2012-10-31 00:00:00', '1 day') AS ts;

--Get the day of the month from the timestamp '2012-08-31' as an integer.
SELECT EXTRACT (DAY FROM timestamp '2012-08-31');

--Work out the number of seconds between the timestamps '2012-08-31 01:00:00' and '2012-09-02 00:00:00'
SELECT EXTRACT(EPOCH FROM timestamp '2012-09-02 00:00:00') -
       EXTRACT(EPOCH FROM timestamp '2012-08-31 01:00:00') AS date_part;

--############ STRING ############

--Output the names of all members, formatted as 'Surname, Firstname'
SELECT mb.surname || ', ' || mb.firstname AS name FROM cd.members mb;

--Find all facilities whose name begins with 'Tennis'. Retrieve all columns.
SELECT * FROM cd.facilities WHERE name LIKE 'Tennis%';

--Perform a case-insensitive search to find all facilities whose name begins with 'tennis'. Retrieve all columns.
SELECT * FROM cd.facilities WHERE name ILIKE 'TENNIS%';

--You've noticed that the club's member table has telephone numbers with very inconsistent formatting. You'd like to find all 
--the telephone numbers that contain parentheses, returning the member ID and telephone number sorted by member ID.
SELECT memid, telephone FROM cd.members WHERE telephone LIKE '(___)%';

--The zip codes in our example dataset have had leading zeroes removed from them by virtue of being stored as a numeric type. 
--Retrieve all zip codes from the members table, padding any zip codes less than 5 characters long with leading zeroes. 
--Order by the new zip code.
SELECT LPAD(CAST(zipcode as VARCHAR(5)), 5, '0') AS zip FROM cd.members
ORDER BY zip;

--You'd like to produce a count of how many members you have whose surname starts with each letter of the alphabet. 
--Sort by the letter, and don't worry about printing out a letter if the count is 0.
SELECT SUBSTRING (surname, 1, 1) AS letter, COUNT(surname) FROM cd.members
GROUP BY letter
ORDER BY letter;

--The telephone numbers in the database are very inconsistently formatted. You'd like to print a list of member ids and numbers 
--that have had '-','(',')', and ' ' characters removed. Order by member id.
SELECT memid, TRANSLATE(telephone, '-() ', '') FROM cd.members;

--############ RECURSIVE ############

--Find the upward recommendation chain for member ID 27: that is, the member who recommended them, and the member who recommended 
--that member, and so on. Return member ID, first name, and surname. Order by descending member id.
WITH RECURSIVE recommenders (recommender) AS (
	SELECT recommendedby FROM cd.members WHERE memid = 27
  	UNION ALL
  	SELECT recommendedby FROM recommenders rec
  	INNER JOIN cd.members mb ON rec.recommender = mb.memid
)
SELECT rec.recommender, mb.firstname, mb.surname FROM recommenders rec
INNER JOIN cd.members mb ON rec.recommender = mb.memid;

--Find the downward recommendation chain for member ID 1: that is, the members they recommended, the members those members 
--recommended, and so on. Return member ID and name, and order by ascending member id.
WITH RECURSIVE recommended(recommendedp) AS (
	SELECT memid FROM cd.members WHERE recommendedby = 1
  	UNION ALL
  	SELECT memid FROM recommended rec
	INNER JOIN cd.members mb ON mb.recommendedby = rec.recommendedp
)

SELECT rec.recommendedp, mb.firstname, mb.surname FROM recommended rec
INNER JOIN cd.members mb ON mb.memid = rec.recommendedp
ORDER BY recommendedp;
