#1. Choose your favorite album and# insert it into the database by doing the following.
#(a) Write a query to insert the band of the album
#(b) Write a query to insert the album
#(c) Write two queries to insert the first two songs of the album
#(d) Write two queries to associate the two songs with the inserted album
select * from Band;

insert into Band (bandId,name) values (1989,'City Girls');
insert into Album (albumId,title,year,number,bandId) values (1990, 'Girl Code', 2018, 5, 1989);
insert into Song (songId, title) values (1991, 'Act up');
insert into Song (songId, title) values (1992, 'Drip');
insert into Song (songId, title) values (1993, 'Broke Boy');
insert into AlbumSong (trackNumber,trackLength,albumId,songId) values (1, 174, 1990, 1991);
insert into AlbumSong (trackNumber,trackLength,albumId,songId) values (2, 200, 1990, 1992);
insert into AlbumSong (trackNumber,trackLength,albumId,songId) values (3, 221, 1990, 1993);

#2. Update the musician record for “P. Best”, his first name should be “Pete”.
select * from Musician where lastName like 'Best';
update Musician set firstName = 'Pete' where musicianId = 1005;

#3. Pete Best was the Beatle’s original drummer, but was fired in 1962. Write a query that
# removes Pete Best from the Beatles.
select * from BandMember; #pete best has musician ID 1005 
select * from BandMember where musicianId = 1005; #beatles have band ID 2001
select * from Band where bandId = 2001; 
delete from BandMember where musicianId = 1005 and bandId = 2001;

#4. Attempt to delete the song “Big in Japan” (by Tom Waits on the album Mule Variations). 
# Write a series of queries that will allow you to delete the album Mule Variations.

# delete from Song where title = 'Big in Japan';
select * from AlbumSong;
delete from AlbumSong where albumId = 
	(select albumId from Album a join Band b on b.bandId = a.bandId 
	where a.title = 'Mule Variations' and b.name = 'Tom Waits');
    
#1. Write a statement to create the table ConcertSong
SET SQL_SAFE_UPDATES=0;
describe AlbumSong;
create table ConcertSong (
concertSongId int not null primary key auto_increment,
songId int not null,
foreign key (songId) references Song (songId)
);
SET SQL_SAFE_UPDATES=1;
describe ConcertSong;

#2. Write a statement to create the table Concert
create table Concert (
concertId int not null primary key auto_increment,
bandId int not null,
date varchar(10),
concertHall varchar(100),
seats int,
ticketsSold int,
foreign key (bandId) references Band (bandId)
);
describe Concert;

#4. Write statement(s) to alter the original tables that you made if needed.
alter table ConcertSong add column concertId int not null,
						add constraint foreign key (concertId) references Concert (concertId);
                        
describe ConcertSong;

#1. Write queries to insert at least two Concert records.
insert into Concert(concertId, bandId, date, concertHall, seats, ticketsSold) values (1, 1989, '2019-01-01', 'Concert Hall 1', 5029, 5001);
insert into Concert(concertId, bandId, date, concertHall, seats, ticketsSold) values (2, 1, '2000-05-23', 'Concert Hall 15', 500, 285);

#2. Write queries to associate at least 3 songs with each of the two concerts
describe AlbumSong;
select * from Song s join AlbumSong asong on asong.songId = s.songId
	join Album a on a.albumId = asong.albumId
	where a.bandId = 1989;
insert into ConcertSong(concertSongId, songId, concertId) values (1, 1991, 1);
insert into ConcertSong(concertSongId, songId, concertId) values (2, 1992, 1);
insert into ConcertSong(concertSongId, songId, concertId) values (3, 1993, 1);

select * from Song s join AlbumSong asong on asong.songId = s.songId
	join Album a on a.albumId = asong.albumId
	where a.bandId = 1;
insert into ConcertSong(concertSongId, songId, concertId) values (4, 1, 2);
insert into ConcertSong(concertSongId, songId, concertId) values (5, 2, 2);
insert into ConcertSong(concertSongId, songId, concertId) values (6, 3, 2);
describe ConcertSong;
select * from ConcertSong;
describe Song;

#3. Write a select-join query to retrieve these new results and produce a playlist for each concert
select s.title from Concert c 
	join ConcertSong cs on cs.concertId = c.concertId 
    join Song s on s.songId = cs.songId 
    where c.bandId = 1989;
select s.title from Concert c 
	join ConcertSong cs on cs.concertId = c.concertId 
    join Song s on s.songId = cs.songId 
    where c.bandId = 1;
    
#4. Modify the query to include the name of the band playing the concert. If such a query
#is not possible, explain why and sketch an alternative design in which it would be possible.
select s.title, b.name from Concert c 
	join Band b on b.bandId = c.bandId
	join ConcertSong cs on cs.concertId = c.concertId 
    join Song s on s.songId = cs.songId 
    where c.bandId = 1989;
select s.title, b.name from Concert c 
	join Band b on b.bandId = c.bandId
	join ConcertSong cs on cs.concertId = c.concertId 
    join Song s on s.songId = cs.songId 
    where c.bandId = 1;







