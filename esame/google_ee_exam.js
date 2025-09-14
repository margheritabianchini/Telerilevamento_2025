// Coordinate di Blatten (metti più precise se le hai)
var blatten = ee.Geometry.Polygon([7.835, 46.419]);

// Periodo di analisi
var startDate = '2016-01-01';
var endDate   = '2023-12-31';

// Collezione Sentinel-2 SR (corretta a livello di superficie)
var s2 = ee.ImageCollection('COPERNICUS/S2_SR')
            .filterBounds(blatten)
            .filterDate(startDate, endDate)
            .filter(ee.Filter.lt('CLOUDY_PIXEL_PERCENTAGE', 20));

// Funzione per aggiungere NDVI (può aiutare a vedere vegetazione disturbata dalla frana)
function addNDVI(img) {
  var ndvi = img.normalizedDifference(['B8','B4']).rename('NDVI');
  return img.addBands(ndvi);
}
var s2_ndvi = s2.map(addNDVI);

// Mediana annuale per ridurre nuvole/rumore
var yearly = ee.ImageCollection(
  ee.List.sequence(2016, 2023).map(function(year) {
    var annual = s2_ndvi.filter(ee.Filter.calendarRange(year, year, 'year'));
    return annual.median().set('year', year);
  })
);

// Visualizza un anno (es. 2020)
var img2020 = yearly.filter(ee.Filter.eq('year', 2020)).first();
Map.centerObject(blatten, 13);
Map.addLayer(img2020, {bands:['B4','B3','B2'], min:0, max:3000}, 'RGB 2020');
Map.addLayer(img2020.select('NDVI'), {min:0, max:1, palette:['brown','green']}, 'NDVI 2020');

// Esporta un’immagine
Export.image.toDrive({
  image: img2020.select(['B4','B3','B2','NDVI']),
  description: 'Blatten_S2_2020',
  region: blatten.buffer(2000), // 2 km attorno al punto
  scale: 10,
  maxPixels: 1e13
});
