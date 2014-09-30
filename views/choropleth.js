var dataset;
var filldata;
d3.json("autogenfill.json", function(error, data){
    dataset = data;

    var choropleth = new Datamap({
	element: document.getElementById('container'),
	projection: 'mercator',
	fills: {
            defaultFill: "#ABDDA4"
	}
    });

    choropleth.updateChoropleth(dataset);
});
