-- ========================================================
-- Spatial Aggregation
-- ========================================================

BEGIN TRAN 

CREATE TABLE tblGeom (
    GXY geometry,                                 -- Geometry data type column
    Description VARCHAR(20),                      -- Description of the shape
    IDtblGeom INT CONSTRAINT PK_tblGeom PRIMARY KEY IDENTITY(5,1)  -- Identity primary key
)

INSERT INTO tblGeom
VALUES 
    (geometry::STGeomFromText('LINESTRING (1 1, 5 5)', 0), 'First line'),
    (geometry::STGeomFromText('LINESTRING (5 1, 1 4, 2 5, 5 1)', 0), 'Second line'),
    (geometry::STGeomFromText('MULTILINESTRING ((1 5, 2 6), (1 4, 2 5))', 0), 'Third line'),
    (geometry::STGeomFromText('POLYGON ((4 1, 6 3, 8 3, 6 1, 4 1))', 0), 'Polygon'),
    (geometry::STGeomFromText('POLYGON ((5 2, 7 2, 7 4, 5 4, 5 2))', 0), 'Second Polygon'),
    (geometry::STGeomFromText('CIRCULARSTRING (1 0, 0 1, -1 0, 0 -1, 1 0)', 0), 'Circle')

SELECT * FROM tblGeom

-- Filter geometries that intersect with a specified polygon (approximate check)
SELECT *  
FROM tblGeom
WHERE GXY.Filter(geometry::Parse('POLYGON((2 1, 1 4, 4 4, 4 1, 2 1))')) = 1
UNION ALL
-- Show the polygon filter itself for visualization
SELECT geometry::STGeomFromText('POLYGON((2 1, 1 4, 4 4, 4 1, 2 1))', 0), 'Filter', 0

-- Union all geometries into a single merged shape (removes internal boundaries)
DECLARE @i AS geometry
SELECT @i = geometry::UnionAggregate(GXY) FROM tblGeom
SELECT @i AS CombinedShapes

-- Combine all geometries into a geometry collection (no merging)
DECLARE @j AS geometry
SELECT @j = geometry::CollectionAggregate(GXY) FROM tblGeom
SELECT @j AS GeometryCollection

-- Calculate the minimal bounding rectangle that contains all shapes
SELECT geometry::EnvelopeAggregate(GXY) AS Envelope FROM tblGeom

-- Calculate the convex hull (tightest convex shape containing all points)
SELECT geometry::ConvexHullAggregate(GXY) AS ConvexHull FROM tblGeom

-- Rollback the transaction (so changes don't persist)
ROLLBACK TRAN
