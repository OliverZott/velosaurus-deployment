-- Demo data: mountain bike tours around Innsbruck
-- Idempotent: rows are only inserted if no row with the same name exists yet
-- Numbers (length km, altitude gain m) are approximate
-- ActivityType: 0 = Bike, 1 = Nordic, 2 = Ski, 3 = Hiking

INSERT INTO "Locations" ("Name", "Region")
SELECT v.name, v.region
FROM (VALUES
    ('Innsbruck', 'Karwendel'),
    ('Mutters', 'Stubaier Alpen'),
    ('Lans', 'Tuxer Alpen')
) AS v(name, region)
WHERE NOT EXISTS (SELECT 1 FROM "Locations" l WHERE l."Name" = v.name);

INSERT INTO "Activities" ("Name", "Date", "Length", "AltitudeGain", "ActivityType", "Description", "LocationId")
SELECT v.name, v.date::timestamptz, v.length, v.altitude_gain, 0, v.description,
       (SELECT l."Id" FROM "Locations" l WHERE l."Name" = v.location ORDER BY l."Id" LIMIT 1)
FROM (VALUES
    ('Arzler Alm Trail', '2026-06-14T09:00:00Z', 11, 480,
     'Uphill from Innsbruck on the forest road to Arzler Alm, then down the flowy Arzler Alm Trail with berms and small jumps back to the city.',
     'Innsbruck'),
    ('Bikepark Mutters', '2026-07-05T10:00:00Z', 14, 750,
     'Climb from Mutters to the Muttereralm and enjoy the bikepark lines and trails on the way down, with views over Innsbruck and the Nordkette.',
     'Mutters'),
    ('Lanser Kopf and Paschberg', '2026-08-23T08:30:00Z', 18, 420,
     'Loop from Innsbruck over the Paschberg to Lanser Kopf and Lanser See, with short singletrails through the forest of the Mittelgebirge.',
     'Lans')
) AS v(name, date, length, altitude_gain, description, location)
WHERE NOT EXISTS (SELECT 1 FROM "Activities" a WHERE a."Name" = v.name);
