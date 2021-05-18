moment.locale('it', {
    months : 'gennaio_febbraio_marzo_aprile_maggio_giugno_luglio_agosto_settembre_ottobre_novembre_dicembre'.split('_'),
    monthsShort : 'gen_feb_mar_apr_mag_giu_lug_ago_set_ott_nov_dic'.split('_'),
    weekdays : 'domenica_lunedì_martedì_mercoledì_giovedì_venerdì_sabato'.split('_'),
    weekdaysShort : 'dom_lun_mar_mer_gio_ven_sab'.split('_'),
    weekdaysMin : 'do_lu_ma_me_gi_ve_sa'.split('_'),
    longDateFormat : {
        LT : 'HH:mm',
        LTS : 'HH:mm:ss',
        L : 'DD/MM/YYYY',
        LL : 'D MMMM YYYY',
        LLL : 'D MMMM YYYY HH:mm',
        LLLL : 'dddd D MMMM YYYY HH:mm'
    },
    calendar : {
        sameDay: '[oggi alle] LT',
        nextDay: '[domani alle] LT',
        nextWeek: 'dddd [alle] LT',
        lastDay: '[ieri alle] LT',
        lastWeek: function () {
            switch (this.day()) {
                case 0:
                    return '[la scorsa] dddd [alle] LT';
                default:
                    return '[lo scorso] dddd [alle] LT';
            }
        },
        sameElse: 'L'
    },
    relativeTime : {
        future : function (s) {
            return ((/^[0-9].+$/).test(s) ? 'tra' : 'in') + ' ' + s;
        },
        past : '%s fa',
        s : 'alcuni secondi',
        ss : '%d secondi',
        m : 'un minuto',
        mm : '%d minuti',
        h : 'un\'ora',
        hh : '%d ore',
        d : 'un giorno',
        dd : '%d giorni',
        M : 'un mese',
        MM : '%d mesi',
        y : 'un anno',
        yy : '%d anni'
    },
    dayOfMonthOrdinalParse : /\d{1,2}º/,
    ordinal: '%dº',
    week : {
        dow : 1, // Monday is the first day of the week.
        doy : 4  // The week that contains Jan 4th is the first week of the year.
    }
});
$(document).ready(function(){	
	var calcolaOrario = function(){
		$("[data-orario]").each(function() {
			var table = $(this);			
			var now = moment();
			
			var currentWeekDay = now.day();			
			table.find('th[data-week_date="'+currentWeekDay+'"]').addClass('bg-warning');

			var openingsIntervals = [];
			var nextClose = false;
			var nextOpen = false;
			
			table.find('td').each(function(){
				var td = $(this);
				var text = td.text();				
				if (text != ''){					
					var orari = text.split('-');
					var weekDay = td.data('week_date')
					if (weekDay == 7){
						weekDay = 0;
					}
					var interval = [];					
					$.each(orari, function(){
						var current = moment();
						var diffWeekDay = weekDay - currentWeekDay;
						if (weekDay > currentWeekDay){
							current.add(diffWeekDay, 'd');
						}else if (weekDay < currentWeekDay){
							diffWeekDay = 7 + diffWeekDay;
							current.add(diffWeekDay, 'd');
						}
						var oraMinuti = this.split('.');	
						current.hour(oraMinuti[0]);
						current.minute(oraMinuti[1]);
						interval.push(current);
					});						
					interval.push(td);					
					openingsIntervals.push(interval);					
				}			
			});
			
			openingsIntervals.sort(function (a, b) {
			    return (b[0].isAfter(a[0])) ? -1 : (a[0].isAfter(b[0])) ? 1 : 0;
			});

			$.each(openingsIntervals, function(){				
				var interval = this;
				var open = interval[0];
				var close = interval[1];
				var td = interval[2];				
				if (now.isBetween(open, close) && nextClose === false){
					nextClose = close;	
					td.addClass('bg-success');						
				}
				if (open.isAfter(now) && nextOpen === false){
					nextOpen = open
				}
			});	

			if(nextClose){
				table.prev().filter('h2').find('span').addClass("btn btn-success").html("APERTO ORA");
				var appendText = '<br />(chiude alle ore ' + nextClose.format("HH:mm") + ')';
				$('[data-market="'+table.data('orario')+'"]').addClass('text-success').removeClass('text-danger').html("<i class='fa fa-clock'></i> Adesso <strong>APERTO</strong>" + appendText)
			}else if (nextOpen){
				table.prev().filter('h2').find('span').removeClass("btn btn-success").empty();
				var appendText = '<br />(apre ' + nextOpen.calendar() + ')';
				$('[data-market="'+table.data('orario')+'"]').addClass('text-danger').removeClass('text-success').html("<i class='fa fa-clock'></i> Adesso <strong>CHIUSO</strong>" + appendText)
			}
		});
	};

	calcolaOrario();
	setInterval(function(){calcolaOrario();}, 600000); //10 minuti
	$(document).on("refresh-market-openings", function (e) {
		calcolaOrario();
	});

	$('.button-orari-di-apertura').on('click', function(){
		calcolaOrario();
	});

	function shouldDisplayOpeningHours() {      	    
	    if ($('.visible-xs').first().is(':visible')){
	    	return false;
	    }
	    if (typeof(sessionStorage) !== "undefined") {
		    return sessionStorage.displayOpeningHours != 1;
		}
		return CurrentNode == 2;      
    }    
    if (shouldDisplayOpeningHours()) {		
		if (typeof(sessionStorage) !== "undefined") {
		    sessionStorage.displayOpeningHours = 1;
		}
    	$('.button-orari-di-apertura').first().trigger('click');
    }
});
