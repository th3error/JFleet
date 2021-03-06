PRAGMA foreign_keys=OFF;
BEGIN TRANSACTION;
CREATE TABLE IF NOT EXISTS "migrations" ("id" integer not null primary key autoincrement, "migration" varchar not null, "batch" integer not null);
INSERT INTO migrations VALUES(1,'2014_10_12_000000_create_users_table',1);
INSERT INTO migrations VALUES(2,'2014_10_12_100000_create_password_resets_table',1);
INSERT INTO migrations VALUES(3,'2019_08_19_000000_create_failed_jobs_table',1);
INSERT INTO migrations VALUES(4,'2019_12_14_000001_create_personal_access_tokens_table',1);
INSERT INTO migrations VALUES(5,'2022_06_24_142753_create_stations_table',1);
INSERT INTO migrations VALUES(8,'2022_06_24_212246_create_buses_table',2);
INSERT INTO migrations VALUES(10,'2022_06_24_173435_create_trips_table',3);
INSERT INTO migrations VALUES(11,'2022_06_24_174604_create_reservations_table',4);
CREATE TABLE IF NOT EXISTS "users" ("id" integer not null primary key autoincrement, "name" varchar not null, "email" varchar not null, "email_verified_at" datetime, "password" varchar not null, "remember_token" varchar, "created_at" datetime, "updated_at" datetime);
INSERT INTO users VALUES(1,'Abdelrahman Moussa','abdelrahman-moussa@outlook.com',NULL,'$2y$10$cDKrE19Mb5AEkwcxdE9QI.TLzILX.kKnQtWUVWqawM7touTuolaKS',NULL,'2022-06-24 16:47:59','2022-06-24 16:47:59');
CREATE TABLE IF NOT EXISTS "password_resets" ("email" varchar not null, "token" varchar not null, "created_at" datetime);
CREATE TABLE IF NOT EXISTS "failed_jobs" ("id" integer not null primary key autoincrement, "uuid" varchar not null, "connection" text not null, "queue" text not null, "payload" text not null, "exception" text not null, "failed_at" datetime default CURRENT_TIMESTAMP not null);
CREATE TABLE IF NOT EXISTS "personal_access_tokens" ("id" integer not null primary key autoincrement, "tokenable_type" varchar not null, "tokenable_id" integer not null, "name" varchar not null, "token" varchar not null, "abilities" text, "last_used_at" datetime, "created_at" datetime, "updated_at" datetime);
INSERT INTO personal_access_tokens VALUES(2,'App\Models\User',1,'myapptoken','3ca574034a62ee30e4abe3a1417814fddf6b30dd905f6ef900e6436320fec3cf','["*"]',NULL,'2022-06-24 17:15:25','2022-06-24 17:15:25');
INSERT INTO personal_access_tokens VALUES(3,'App\Models\User',1,'myapptoken','15a0848bd2931d9e0ec3f5be31067955d0639da2ca62b007f0749564046b595d','["*"]','2022-06-25 21:28:04','2022-06-25 19:50:07','2022-06-25 21:28:04');
CREATE TABLE IF NOT EXISTS "stations" ("id" integer not null primary key autoincrement, "name" varchar not null, "status" tinyint(1) not null, "created_at" datetime, "updated_at" datetime);
INSERT INTO stations VALUES(1,'Test station',0,'2022-06-24 14:57:47','2022-06-24 15:41:02');
INSERT INTO stations VALUES(2,'Cairo',1,'2022-06-24 15:10:28','2022-06-24 15:10:28');
INSERT INTO stations VALUES(4,'Alexandria',1,'2022-06-24 15:47:18','2022-06-24 15:51:05');
INSERT INTO stations VALUES(5,'Suez',1,'2022-06-24 16:49:30','2022-06-24 16:49:30');
INSERT INTO stations VALUES(6,'AlFayyum',1,'2022-06-24 23:03:32','2022-06-24 23:03:32');
INSERT INTO stations VALUES(7,'AlMinya',1,'2022-06-24 23:03:41','2022-06-24 23:03:41');
INSERT INTO stations VALUES(8,'Asyut',1,'2022-06-24 23:03:48','2022-06-24 23:03:48');
CREATE TABLE IF NOT EXISTS "buses" ("id" integer not null primary key autoincrement, "name" varchar not null, "seat_count" integer not null default '12', "created_at" datetime, "updated_at" datetime);
INSERT INTO buses VALUES(1,'Super-Class',12,'2022-06-25 15:50:40','2022-06-25 15:50:40');
INSERT INTO buses VALUES(2,'Super-Class',12,'2022-06-25 15:50:57','2022-06-25 15:50:57');
CREATE TABLE IF NOT EXISTS "trips" ("id" integer not null primary key autoincrement, "name" varchar not null, "start_station_id" integer not null, "end_station_id" integer not null, "bus_id" integer not null, "inbetween_trip_ids" text, "created_at" datetime, "updated_at" datetime);
INSERT INTO trips VALUES(2,'Cairo-AlFayyum',2,6,1,NULL,'2022-06-25 13:57:41','2022-06-25 13:57:41');
INSERT INTO trips VALUES(3,'Cairo-AlMinya',2,7,1,'[2,4]','2022-06-25 13:59:57','2022-06-25 13:59:57');
INSERT INTO trips VALUES(4,'AlFayyum-AlMinya',6,7,1,NULL,'2022-06-25 14:02:19','2022-06-25 14:02:19');
INSERT INTO trips VALUES(5,'AlFayyum-Asyut',6,8,1,'[4,6]','2022-06-25 14:03:46','2022-06-25 14:03:46');
INSERT INTO trips VALUES(6,'AlMinya-Asyut',7,8,1,NULL,'2022-06-25 14:04:47','2022-06-25 14:04:47');
INSERT INTO trips VALUES(7,'Cairo-Asyut',2,8,1,'[2,4,6]','2022-06-25 14:26:00','2022-06-25 14:26:00');
CREATE TABLE IF NOT EXISTS "reservations" ("id" integer not null primary key autoincrement, "main_trip_id" integer not null, "trip_id" integer not null, "user_id" integer not null, "seat_id" integer not null, "created_at" datetime, "updated_at" datetime);
INSERT INTO reservations VALUES(2,2,2,1,5,'2022-06-25 14:10:40','2022-06-25 14:10:40');
INSERT INTO reservations VALUES(3,3,2,1,3,'2022-06-25 14:12:24','2022-06-25 14:12:24');
INSERT INTO reservations VALUES(4,3,4,1,3,'2022-06-25 14:12:50','2022-06-25 14:12:50');
INSERT INTO reservations VALUES(5,7,2,1,1,'2022-06-25 14:19:10','2022-06-25 14:19:10');
INSERT INTO reservations VALUES(7,7,4,1,1,'2022-06-25 14:20:16','2022-06-25 14:20:16');
INSERT INTO reservations VALUES(9,7,6,1,1,'2022-06-25 14:20:27','2022-06-25 14:20:27');
INSERT INTO reservations VALUES(10,2,2,1,2,'2022-06-25 21:19:36','2022-06-25 21:19:36');
INSERT INTO reservations VALUES(11,7,2,1,4,'2022-06-25 21:26:54','2022-06-25 21:26:54');
INSERT INTO reservations VALUES(12,7,4,1,4,'2022-06-25 21:26:54','2022-06-25 21:26:54');
INSERT INTO reservations VALUES(13,7,6,1,4,'2022-06-25 21:26:54','2022-06-25 21:26:54');
INSERT INTO reservations VALUES(14,7,2,1,6,'2022-06-25 21:28:04','2022-06-25 21:28:04');
INSERT INTO reservations VALUES(15,7,4,1,6,'2022-06-25 21:28:04','2022-06-25 21:28:04');
INSERT INTO reservations VALUES(16,7,6,1,6,'2022-06-25 21:28:04','2022-06-25 21:28:04');
DELETE FROM sqlite_sequence;
INSERT INTO sqlite_sequence VALUES('migrations',11);
INSERT INTO sqlite_sequence VALUES('stations',8);
INSERT INTO sqlite_sequence VALUES('users',1);
INSERT INTO sqlite_sequence VALUES('personal_access_tokens',3);
INSERT INTO sqlite_sequence VALUES('trips',7);
INSERT INTO sqlite_sequence VALUES('reservations',16);
INSERT INTO sqlite_sequence VALUES('buses',2);
CREATE UNIQUE INDEX "users_email_unique" on "users" ("email");
CREATE INDEX "password_resets_email_index" on "password_resets" ("email");
CREATE UNIQUE INDEX "failed_jobs_uuid_unique" on "failed_jobs" ("uuid");
CREATE INDEX "personal_access_tokens_tokenable_type_tokenable_id_index" on "personal_access_tokens" ("tokenable_type", "tokenable_id");
CREATE UNIQUE INDEX "personal_access_tokens_token_unique" on "personal_access_tokens" ("token");
COMMIT;
