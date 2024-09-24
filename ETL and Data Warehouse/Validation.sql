DELIMITER //

CREATE PROCEDURE Incremental_Load_Fact_Table()
BEGIN
    DECLARE cur_time TIMESTAMP;
    SET cur_time = NOW();

    -- Step 1: Insert new records into fact_table
    INSERT INTO car_accident_dwh.fact_table 
    (
        Num_Acc, date, region, hour, dep, Country, lum, inter, col, circ, vosp, 
        prof, plan, surf, situ, temperature_C, visibility_meters, weather_Condition, 
        longitude, latitude, weather_Conditions_UK
    )
    SELECT 
        staging.Num_Acc, 
        staging.date, 
        staging.region, 
        staging.hour, 
        staging.dep, 
        staging.Country, 
        staging.lum, 
        staging.inter, 
        staging.col, 
        staging.circ, 
        staging.vosp, 
        staging.prof, 
        staging.plan, 
        staging.surf, 
        staging.situ, 
        staging.temperature_C, 
        staging.visibility_meters, 
        staging.weather_Condition, 
        staging.longitude, 
        staging.latitude, 
        staging.weather_Conditions_UK
    FROM 
        car_accident_staging_db.caracteristic AS staging
    LEFT JOIN 
        car_accident_dwh.fact_table AS dwh
    ON 
        staging.Num_Acc = dwh.Num_Acc
    WHERE 
        dwh.Num_Acc IS NULL;  -- Insert only new records

    -- Step 2: Update existing records in fact_table
    UPDATE car_accident_dwh.fact_table AS dwh
    JOIN car_accident_staging_db.caracteristic AS staging
    ON dwh.Num_Acc = staging.Num_Acc
    SET 
        dwh.date = staging.date,
        dwh.region = staging.region,
        dwh.hour = staging.hour,
        dwh.dep = staging.dep,
        dwh.Country = staging.Country,
        dwh.lum = staging.lum,
        dwh.inter = staging.inter,
        dwh.col = staging.col,
        dwh.circ = staging.circ,
        dwh.vosp = staging.vosp,
        dwh.prof = staging.prof,
        dwh.plan = staging.plan,
        dwh.surf = staging.surf,
        dwh.situ = staging.situ,
        dwh.temperature_C = staging.temperature_C,
        dwh.visibility_meters = staging.visibility_meters,
        dwh.weather_Condition = staging.weather_Condition,
        dwh.longitude = staging.longitude,
        dwh.latitude = staging.latitude,
        dwh.weather_Conditions_UK = staging.weather_Conditions_UK
    WHERE 
        staging.last_updated > dwh.last_updated;  -- Only update if staging record is newer

END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE Incremental_Load_Weather()
BEGIN
    DECLARE cur_time TIMESTAMP;
    SET cur_time = NOW();

    -- Step 1: Insert new records into weather table
    INSERT INTO car_accident_dwh.weather 
    (
        date, region, temperature_C, humidity_percent, wind_speed_m_s, 
        precipitation_mm, visibility_meters, weather_Condition, 
        pressure_hpa, sunshine_duration_hours
    )
    SELECT 
        staging.date, 
        staging.region, 
        staging.temperature_C, 
        staging.humidity_percent, 
        staging.wind_speed_m_s, 
        staging.precipitation_mm, 
        staging.visibility_meters, 
        staging.weather_Condition, 
        staging.pressure_hpa, 
        staging.sunshine_duration_hours
    FROM 
        car_accident_staging_db.weather AS staging
    LEFT JOIN 
        car_accident_dwh.weather AS dwh
    ON 
        staging.date = dwh.date AND staging.region = dwh.region
    WHERE 
        dwh.date IS NULL AND dwh.region IS NULL;  -- Insert only new records

    -- Step 2: Update existing records in weather table
    UPDATE car_accident_dwh.weather AS dwh
    JOIN car_accident_staging_db.weather AS staging
    ON dwh.date = staging.date AND dwh.region = staging.region
    SET 
        dwh.temperature_C = staging.temperature_C,
        dwh.humidity_percent = staging.humidity_percent,
        dwh.wind_speed_m_s = staging.wind_speed_m_s,
        dwh.precipitation_mm = staging.precipitation_mm,
        dwh.visibility_meters = staging.visibility_meters,
        dwh.weather_Condition = staging.weather_Condition,
        dwh.pressure_hpa = staging.pressure_hpa,
        dwh.sunshine_duration_hours = staging.sunshine_duration_hours
    WHERE 
        staging.last_updated > dwh.last_updated;  -- Only update if staging record is newer

END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE Incremental_Load_Users_Dm()
BEGIN
    DECLARE cur_time TIMESTAMP;
    SET cur_time = NOW();

    -- Step 1: Insert new records into users_dm
    INSERT INTO car_accident_dwh.users_dm 
    (
        user_id, Num_Acc, sex, age, trajet, an_nat, safety_existence, 
        safety_use, car_condition, wheels_condition, vehicle_company, 
        speed, catu, grav
    )
    SELECT 
        staging.user_id, 
        staging.Num_Acc, 
        staging.sex, 
        staging.age, 
        staging.trajet, 
        staging.an_nat, 
        staging.safety_existence, 
        staging.safety_use, 
        staging.car_condition, 
        staging.wheels_condition, 
        staging.vehicle_company, 
        staging.speed, 
        staging.catu, 
        staging.grav
    FROM 
        car_accident_staging_db.users_dm AS staging
    LEFT JOIN 
        car_accident_dwh.users_dm AS dwh
    ON 
        staging.Num_Acc = dwh.Num_Acc
    WHERE 
        dwh.Num_Acc IS NULL;  -- Insert only new records

    -- Step 2: Update existing records in users_dm
    UPDATE car_accident_dwh.users_dm AS dwh
    JOIN car_accident_staging_db.users_dm AS staging
    ON dwh.Num_Acc = staging.Num_Acc
    SET 
        dwh.sex = staging.sex,
        dwh.age = staging.age,
        dwh.trajet = staging.trajet,
        dwh.an_nat = staging.an_nat,
        dwh.safety_existence = staging.safety_existence,
        dwh.safety_use = staging.safety_use,
        dwh.car_condition = staging.car_condition,
        dwh.wheels_condition = staging.wheels_condition,
        dwh.vehicle_company = staging.vehicle_company,
        dwh.speed = staging.speed,
        dwh.catu = staging.catu,
        dwh.grav = staging.grav
    WHERE 
        staging.last_updated > dwh.last_updated;  -- Only update if staging record is newer

END //

DELIMITER ;

SET GLOBAL event_scheduler = ON;

CREATE EVENT IF NOT EXISTS Daily_Incremental_Load_Fact_Table
ON SCHEDULE EVERY 1 DAY
STARTS CURRENT_TIMESTAMP + INTERVAL 1 DAY
DO
    CALL Incremental_Load_Fact_Table();

CREATE EVENT IF NOT EXISTS Daily_Incremental_Load_Users_Dm
ON SCHEDULE EVERY 1 DAY
STARTS CURRENT_TIMESTAMP + INTERVAL 1 DAY
DO
    CALL Incremental_Load_Users_Dm();

CREATE EVENT IF NOT EXISTS Daily_Incremental_Load_Weather
ON SCHEDULE EVERY 1 DAY
STARTS CURRENT_TIMESTAMP + INTERVAL 1 DAY
DO
    CALL Incremental_Load_Weather();

DELIMITER //

CREATE PROCEDURE Full_Load_Other_Tables()
BEGIN
    DECLARE cur_time TIMESTAMP;
    SET cur_time = NOW();

    -- Step 1: Full load for places_category
    TRUNCATE TABLE car_accident_dwh.places_category;
    INSERT INTO car_accident_dwh.places_category (catr, Category)
    SELECT 
        source.catr, 
        source.Category
    FROM 
        some_source_database.places_category AS source;

    -- Step 2: Full load for characteristic_intersection
    TRUNCATE TABLE car_accident_dwh.characteristic_intersection;
    INSERT INTO car_accident_dwh.characteristic_intersection (inter, Category)
    SELECT 
        source.inter, 
        source.Category
    FROM 
        some_source_database.characteristic_intersection AS source;

    -- Step 3: Full load for characteristic_collision
    TRUNCATE TABLE car_accident_dwh.characteristic_collision;
    INSERT INTO car_accident_dwh.characteristic_collision (col, Category)
    SELECT 
        source.col, 
        source.Category
    FROM 
        some_source_database.characteristic_collision AS source;

    -- Step 4: Full load for places_situation
    TRUNCATE TABLE car_accident_dwh.places_situation;
    INSERT INTO car_accident_dwh.places_situation (situ, Situation)
    SELECT 
        source.situ, 
        source.Situation
    FROM 
        some_source_database.places_situation AS source;

    -- Step 5: Full load for places_profile
    TRUNCATE TABLE car_accident_dwh.places_profile;
    INSERT INTO car_accident_dwh.places_profile (prof, profile)
    SELECT 
        source.prof, 
        source.profile
    FROM 
        some_source_database.places_profile AS source;

    -- Step 6: Full load for places_plan
    TRUNCATE TABLE car_accident_dwh.places_plan;
    INSERT INTO car_accident_dwh.places_plan (plan, DrawingPlan)
    SELECT 
        source.plan, 
        source.DrawingPlan
    FROM 
        some_source_database.places_plan AS source;

    -- Step 7: Full load for places_surface
    TRUNCATE TABLE car_accident_dwh.places_surface;
    INSERT INTO car_accident_dwh.places_surface (surf, Surface)
    SELECT 
        source.surf, 
        source.Surface
    FROM 
        some_source_database.places_surface AS source;

    -- Step 8: Full load for places_lane
    TRUNCATE TABLE car_accident_dwh.places_lane;
    INSERT INTO car_accident_dwh.places_lane (vosp, Lane)
    SELECT 
        source.vosp, 
        source.Lane
    FROM 
        some_source_database.places_lane AS source;

    -- Step 9: Full load for places_traffic
    TRUNCATE TABLE car_accident_dwh.places_traffic;
    INSERT INTO car_accident_dwh.places_traffic (circ, Traffic)
    SELECT 
        source.circ, 
        source.Traffic
    FROM 
        some_source_database.places_traffic AS source;

    -- Step 10: Full load for users_category
    TRUNCATE TABLE car_accident_dwh.users_category;
    INSERT INTO car_accident_dwh.users_category (catu, Category)
    SELECT 
        source.catu, 
        source.Category
    FROM 
        some_source_database.users_category AS source;

    -- Step 11: Full load for vehicles_category
    TRUNCATE TABLE car_accident_dwh.vehicles_category;
    INSERT INTO car_accident_dwh.vehicles_category (catv, Category)
    SELECT 
        source.catv, 
        source.Category
    FROM 
        some_source_database.vehicles_category AS source;

    -- Step 12: Full load for characteristic_lighting
    TRUNCATE TABLE car_accident_dwh.characteristic_lighting;
    INSERT INTO car_accident_dwh.characteristic_lighting (lum, Category)
    SELECT 
        source.lum, 
        source.Category
    FROM 
        some_source_database.characteristic_lighting AS source;

    -- Step 13: Full load for users_reason
    TRUNCATE TABLE car_accident_dwh.users_reason;
    INSERT INTO car_accident_dwh.users_reason (trajet, Reason)
    SELECT 
        source.trajet, 
        source.Reason
    FROM 
        some_source_database.users_reason AS source;

END //

DELIMITER ;

SET GLOBAL event_scheduler = ON;

CREATE EVENT IF NOT EXISTS Weekly_Full_Load_Other_Tables
ON SCHEDULE EVERY 1 WEEK
STARTS CURRENT_TIMESTAMP + INTERVAL 1 WEEK
DO
    CALL Full_Load_Other_Tables();