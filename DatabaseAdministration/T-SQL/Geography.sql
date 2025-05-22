BEGIN TRAN  -- Begin transaction for safe testing

-- Create a table to store GEOGRAPHY data 
CREATE TABLE tblGeog (
    GXY geography,  
    Description VARCHAR(30),  
    IDtblGeog INT CONSTRAINT PK_tblGeog PRIMARY KEY IDENTITY(1,1)  -- Unique ID for each record
)

-- Insert point locations and a connecting linestring between them
-- Coordinates are in (longitude latitude) format
INSERT INTO tblGeog
VALUES 
    (geography::STGeomFromText('POINT (-73.993492 40.750525)', 4326), 'Madison Square Gardens, NY'),
    (geography::STGeomFromText('POINT (-0.177452 51.500905)', 4326), 'Royal Albert Hall, London'),
    (geography::STGeomFromText('LINESTRING (-73.993492 40.750525, -0.177452 51.500905)', 4326), 'Connection')

-- View all inserted geography records
SELECT * FROM tblGeog

-- Load a geography point into a variable for spatial comparison
DECLARE @g AS geography
SELECT @g = GXY FROM tblGeog WHERE IDtblGeog = 1  -- Madison Square Gardens

-- Analyze each geometry and compare it with @g
SELECT 
    IDtblGeog,
    GXY.STGeometryType() AS MyType,  -- Type of the spatial object (POINT or LINESTRING)
    GXY.STStartPoint().ToString() AS StartingPoint,  -- Start point (mainly for LINESTRING)
    GXY.STEndPoint().ToString() AS EndingPoint,  -- End point (mainly for LINESTRING)
    GXY.STPointN(1).ToString() AS FirstPoint,  -- Get first point in the shape
    GXY.STPointN(2).ToString() AS SecondPoint,  -- Get second point if available
    GXY.STLength() AS MyLength,  -- Length of the shape in meters
    GXY.STIntersection(@g).ToString() AS Intersection,  -- Geometric intersection with @g
    GXY.STNumPoints() AS NumberPoints,  -- Count of points in the shape
    GXY.STDistance(@g) AS DistanceFromFirstLine  -- Distance in meters from @g
FROM tblGeog

-- Load second geography point into another variable
DECLARE @h AS geography
SELECT @h = GXY FROM tblGeog WHERE IDtblGeog = 2  -- Royal Albert Hall

-- Compute great-circle distance between two geographic points
SELECT @g.STDistance(@h) AS MyDistance

-- Perform a union operation to combine spatial objects
SELECT GXY.STUnion(@g) AS UnionedShape
FROM tblGeog
WHERE IDtblGeog = 2  -- Combine with Madison Square Gardens

-- View available spatial reference systems
SELECT * FROM sys.spatial_reference_systems

ROLLBACK TRAN  -- Roll back changes to avoid persisting test data
