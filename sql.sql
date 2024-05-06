create database sbtbasic;
use sbtbasic;


create table user_info(
                          id varchar(50) not null,
                          pwd varchar(50),
                          name varchar(50),
                          email varchar(100),
                          birth date,
                          sns varchar(20),
                          reg_date date default now(),
                          constraint user_pk primary key (id)
);

create table board (
                       bno int not null auto_increment,
                       title varchar(100) not null,
                       content text not null,
                       writer varchar(50) not null,
                       view_cnt int default 0,
                       comment_cnt int default 0,
                       reg_date datetime default now(),
                       up_date datetime default now(),
                       constraint board_pk primary key (bno),
                       foreign key (writer) references user_info(id)
);

create table comment (
                         cno int not null auto_increment,
                         bno int not null,
                         pcno int,
                         comment varchar(3000),
                         commenter varchar(50),
                         reg_date datetime default now(),
                         up_date datetime default now(),
                         constraint comment_pk primary key (cno),
                         foreign key (bno) references board(bno) on delete cascade,
                         foreign key (commenter) references user_info(id)
);