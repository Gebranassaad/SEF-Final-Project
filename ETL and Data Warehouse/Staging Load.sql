truncate table car_accident_staging_db.users;
LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\users.csv'
INTO TABLE car_accident_staging_db.users
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES
(Num_Acc, place, catu,grav , sexe, trajet, secu, locp, actp, etatp,an_nais , num_veh );

truncate table car_accident_staging_db.caracteristics;
LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\caracteristics.csv'
INTO TABLE car_accident_staging_db.caracteristics
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES
(Num_Acc, an, mois, jour, hrmn, lum, agg, inter, atm, col, com, adr, gps, lat, longi, dep);

truncate table car_accident_staging_db.places;
LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\places.csv'
INTO TABLE car_accident_staging_db.places
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES
(Num_Acc, catr, voie, v1, v2, circ, nbv, pr, pr1, vosp, prof, plan, lartpc, larrout, surf, infra, situ, env1);

truncate table car_accident_staging_db.vehicles;
LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\vehicles.csv'
INTO TABLE car_accident_staging_db.vehicles
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES
(Num_Acc, senc, catv, occutc, obs, obsm, choc, manv, num_veh);
