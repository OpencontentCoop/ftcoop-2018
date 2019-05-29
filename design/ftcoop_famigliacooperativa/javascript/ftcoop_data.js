Highcharts.setOptions(Highcharts.theme);
var colors = Highcharts.getOptions().colors;

function draw_lavoratori( data, container ){
    chart = new Highcharts.Chart({
		chart: {
			renderTo: container,
			zoomType: 'xy'
		},
		title: {
			text: ''
		},
		legend: {
            labelFormatter: function() { return this.name; }
        },
		xAxis: {
			categories: data.categories
		},
		yAxis: {
            labels: {
                formatter: function() { return this.value; },
                style: { color: colors[7] }
            },
            title: {
                text: data.llabel,
                style: { color: colors[7] }
            }
        },
		tooltip: {
			enabled: true,
			formatter: function() {
                nStr = this.y + '';
                x = nStr.split('.');
                x1 = x[0];
                x2 = x.length > 1 ? '.' + x[1] : '';
                var rgx = /(\d+)(\d{3})/;
                while (rgx.test(x1)) {
                    x1 = x1.replace(rgx, '$1' + '.' + '$2');
                }
				return '<b>'+ this.series.name +'</b><br/>'+ this.x +': '+ (x1 + x2);
			}
		},
		plotOptions: {
			line: {
				dataLabels: {
					enabled: false,
					formatter: function() {
						nStr = this.y + '';
						x = nStr.split('.');
						x1 = x[0];
						x2 = x.length > 1 ? '.' + x[1] : '';
						var rgx = /(\d+)(\d{3})/;
						while (rgx.test(x1)) {
							x1 = x1.replace(rgx, '$1' + '.' + '$2');
						}
						return x1 + x2;
                    }
				},
				enableMouseTracking: true
			}
		},labels: {
            items: [{
                html: 'Dati <a href="http://cooperazionetrentina.it">Federazione Trentina della Cooperazione</a>',
                style: { left: '0', top: '0', color: '#bbb', 'font-size': '10px' }
            }]
		},
		series: [
            {
                name: data.chart_label,
                type: data.chart_type,
                color: colors[7],
                data: data.data
            }
		]
	});    
}

function draw_soci( data, container )
{
    chart = new Highcharts.Chart({
		chart: {
			renderTo: container,
			zoomType: 'xy'
		},
		title: {
			text: ''
		},
		legend: {
            labelFormatter: function() { return this.name; }
        },
		xAxis: {
			categories: data.categories
		},
		yAxis: {
            labels: {
                formatter: function() { return this.value; },
                style: { color: colors[0] }
            },
            title: {
                text: data.llabel,
                style: { color: colors[0]}
            }
        },
		tooltip: {
			enabled: true,
			formatter: function() {
                nStr = this.y + '';
                x = nStr.split('.');
                x1 = x[0];
                x2 = x.length > 1 ? '.' + x[1] : '';
                var rgx = /(\d+)(\d{3})/;
                while (rgx.test(x1)) {
                    x1 = x1.replace(rgx, '$1' + '.' + '$2');
                }
				return '<b>'+ this.series.name + '</b><br/>' + this.x +': '+ (x1 + x2);
			}
		},
		plotOptions: {
			line: {
				dataLabels: {
					enabled: false,
					formatter: function() {
						nStr = this.y + '';
						x = nStr.split('.');
						x1 = x[0];
						x2 = x.length > 1 ? '.' + x[1] : '';
						var rgx = /(\d+)(\d{3})/;
						while (rgx.test(x1)) {
							x1 = x1.replace(rgx, '$1' + '.' + '$2');
						}
						return x1 + x2;
                    }
				},
				enableMouseTracking: true
			}
		},
        labels: {
            items: [{
                html: 'Dati <a href="http://cooperazionetrentina.it">Federazione Trentina della Cooperazione</a>',
                style: { left: '0', top: '0', color: '#bbb', 'font-size': '10px' }
            }]
		},
		series: [
            {
                name: data.chart_label,
                type: data.chart_type,
                color: colors[0],
                data: data.data
            }
		]
	});    
}

function draw_bilancio( data, container )
{
    var chart = new Highcharts.Chart({
        chart: {
            renderTo: container,
            zoomType: 'xy'
        },
        title: {
            text: ''
        },
        legend: {
            labelFormatter: function() { return this.name; }
        },
        xAxis: {
            categories: data.categories
        },
        yAxis: {
            labels: {
            formatter: function() {
                var value = this.value * data.lfactor;
                if( value == value.toFixed(2) ) return value;
                else return value.toFixed(2);
                },
                style: { color: '#000000' }
            },
            title: {
                text: data.llabel,
                style: { color: '#000000' }
            }
        },
        tooltip: {
            enabled: true,
            formatter: function() {
                var lfactor = data.lfactor;
                var rfactor = data.rfactor;
                var suffix;
                nStr = this.y + '';
                x = nStr.split('.');
                x1 = x[0];
                x2 = x.length > 1 ? '.' + x[1] : '';
                var rgx = /(\d+)(\d{3})/;
                while (rgx.test(x1)) {
                    x1 = x1.replace(rgx, '$1' + '.' + '$2');
                }
                var retval = x1 + x2;
                var str = this.series.name;
                if( this.series.name == data.llabel ){
                    retval = this.y * lfactor;
                    if( lfactor == 1 ) suffix = " mila euro";
                    else suffix = " mln di euro";
                }else{
                    retval = this.y * rfactor;
                    if( rfactor == 1 ) suffix = " mila euro";
                    else suffix = " mln di euro";
                }
                if( retval != retval.toFixed(2) ) retval = retval.toFixed(2);
                return '<b>'+ this.series.name +' ' + this.x + '</b><br/>' + retval + suffix;
              }
        },
        plotOptions: {
            line: {
                dataLabels: {
                    enabled: false,
                    formatter: function() {
                        nStr = this.y + '';
                        x = nStr.split('.');
                        x1 = x[0];
                        x2 = x.length > 1 ? '.' + x[1] : '';
                        var rgx = /(\d+)(\d{3})/;
                        while (rgx.test(x1)) {
                            x1 = x1.replace(rgx, '$1' + '.' + '$2');
                        }
                        return x1 + x2;
                    }
                },
                enableMouseTracking: true
            }
        },
        labels: {
            items: [{
                html: 'Dati <a href="http://cooperazionetrentina.it">Federazione Trentina della Cooperazione</a>',
                style: { left: '0', top: '0', color: '#bbb', 'font-size': '10px' }
            }]
        },
        series: [
            {
                name: data.fatturato.chart_label,
                type: data.fatturato.chart_type,
                color: colors[0],
                zIndex: 1,
                data: data.fatturato.data
            },
            {
                name: data.patrimonio.chart_label,
                type: data.patrimonio.chart_type,
                color: colors[1],
                zIndex: 0,
                data: data.patrimonio.data
            },
            {
                name: data.utile.chart_label,
                type: data.utile.chart_type,
                color: colors[7],
                zIndex: 2,
                data: data.utile.data
            }
        ]
    });    
}


function drawPieChart(data, container){
  var browserData = [];
  var versionsData = [];
  for (var i = 0; i < data.data.data.length; i++) {
    // add browser data
    browserData.push({
      name: data.data.categories[i],
      y: data.data.data[i].y,
      color: data.data.data[i].color
    });
    // add version data
    for (var j = 0; j < data.data.data[i].drilldown.data.length; j++) {
      var brightness = 0.2 - (j / data.data.data[i].drilldown.data.length) / 5 ;
      versionsData.push({
        name: data.data.data[i].drilldown.categories[j],
        link: data.data.data[i].drilldown.links[j],
        y: data.data.data[i].drilldown.data[j],
        color: Highcharts.Color(data.data.data[i].color).brighten(brightness).get()
      });
    }
  }
  return new Highcharts.Chart({
    chart: {
      renderTo: container,
      type: 'pie'
    },
    title: {
      text: data.data.title
    },
    yAxis: {
      title: {
        text: data.name
      }
    },
    plotOptions: {
      pie: {
        shadow: false
      }
    },
    tooltip: {
      formatter: function() {
        return '<strong>'+ this.point.name +'</strong>';
      }
    },
    legend: {
      layout: 'vertical',
      align: 'left',
      verticalAlign: 'top',
      x: 10,
      y: 10,
      labelFormatter: function() {
        return this.name;
      }
    },labels: {
      items: [{
        html: '', // 'Powered by <a href="http://shop.highsoft.com/faq#what-is-commercial-website">"Highcharts JS"</a>',
        style: {
          left: '100px',
          top: '260px',
          color: 'white'
        }
      }]
    },
    series: [{
      name: 'Organi',
      data: browserData,
      showInLegend: true,
      size: '60%',
      dataLabels: {
        formatter: function() {
          return null; // this.y > 0 ? this.point.name : null;
        },
        color: 'white',
        distance: -30
      }
    }, {
      name: 'Componenti',
      data: versionsData,
      innerSize: '60%',
      dataLabels: {
        formatter: function() {
          // display only if larger than 1
          return this.y > 0 ? '<strong><a href="'+this.point.link+'">'+ this.point.name +'</a></strong> '  : null;
        },
        color: '#000000'
      }
    }]
  });
}



$(document).ready(function(){
	if ($('[data-ftcoop]').length > 0){
		$.getJSON( "//www.cooperazionetrentina.it/ftc/data/coop/?partita_iva="+PartitaIva+"&callback=?", {}, function(response, status, xhr) {        				
			if (status == 'success'){ 
				if (response.data.bilancio.data.has_data && $('[data-ftcoop="bilancio"]').length > 0) {
          draw_bilancio( response.data.bilancio.data, $('[data-ftcoop="bilancio"]')[0] );
        }
        if ($('[data-ftcoop="soci"]').length > 0) {
          draw_soci( response.data.soci.data, $('[data-ftcoop="soci"]')[0] );
        }
        if ($('[data-ftcoop="lavoratori"]').length > 0) {
          draw_lavoratori( response.data.lavoratori.data, $('[data-ftcoop="lavoratori"]')[0] );
        }

        if ($('[data-ftcoop="cda"]').length > 0) {
          draw_lavoratori( response.data.cda, $('[data-ftcoop="cda"]')[0] );
        }

			}  
		});
	}
});