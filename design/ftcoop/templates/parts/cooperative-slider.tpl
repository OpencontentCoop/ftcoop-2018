{ezscript_require( array( 'ezjsc::jquery', 'plugins/owl-carousel/owl.carousel.min.js', "plugins/blueimp/jquery.blueimp-gallery.min.js" , "owl-carousel-activation.js" ) )}
{*ezcss_require( array( 'plugins/owl-carousel/owl.carousel.min.css', 'plugins/owl-carousel/owl.theme.default.css', "plugins/blueimp/blueimp-gallery.css" ) )*}
{ezcss_require( array( "plugins/blueimp/blueimp-gallery.css" ) )}

<div class="carousel-container owl-carousel-wide cooperative">

  <div id="cooperative-987" class="owl-carousel owl-theme">

      <div class="carousel-item agricole">
        <a href="{'/Cooperative/(settore)/764620'|ezurl(no)}">
          <img src={'images/photo/agricole.png'|ezdesign()} />
          <h3>Cooperative <span>Agricole</span></h3>
          <span class="fa-stack fa-1x">
            <i class="far fa-circle fa-stack-2x"></i>
            <i class="fa fa-plus fa-stack-1x" ></i>
          </span>
          <span class="sr-only">Vedi</span>
          <div class="overlay">
            <p class="overlay-text">
              Testo Cooperative Agricole<br />
              Scopri di più +
            </p>
          </div>
        </a>
      </div>

      <div class="carousel-item consumo" >
        <a href="{'/Cooperative/(settore)/764615'|ezurl(no)}">
          <img src={'images/photo/consumo.png'|ezdesign()} />
          <h3>Cooperative <span>Consumo</span></h3>
          <span class="fa-stack fa-1x">
            <i class="far fa-circle fa-stack-2x"></i>
            <i class="fa fa-plus fa-stack-1x" ></i>
          </span>
          <span class="sr-only">Vedi</span>
          <div class="overlay">
            <p class="overlay-text">
              Testo Coperative di Consumo<br />
              Scopri di più +
            </p>
          </div>
        </a>
      </div>

      <div class="carousel-item lssa">
        <a href="{'/Cooperative/(settore)/764610'|ezurl(no)}">
          <img src={'images/photo/lssa.png'|ezdesign()} />
          <h3>Cooperative <span>Lavoro, Servizio, Sociale, Abitazione</span></h3>
          <span class="fa-stack fa-1x">
            <i class="far fa-circle fa-stack-2x"></i>
            <i class="fa fa-plus fa-stack-1x" ></i>
          </span>
          <span class="sr-only">Vedi</span>
          <div class="overlay">
            <p class="overlay-text">
              Testo Cooperative di Lavoro, Servizio, Sociale, Abitazione<br />
              Scopri di più +
            </p>
          </div>
        </a>
      </div>

      <div class="carousel-item credito">
        <a href="{'/Cooperative/(settore)/764605'|ezurl(no)}">
          <img src={'images/photo/credito.png'|ezdesign()}/>
          <h3>Cooperative <span>Credito</span></h3>
          <span class="fa-stack fa-1x">
            <i class="far fa-circle fa-stack-2x"></i>
            <i class="fa fa-plus fa-stack-1x" ></i>
          </span> <span class="sr-only">Vedi</span>
          <div class="overlay">
            <p class="overlay-text">
              Testo Cooperative di Credito<br />
              Scopri di più +
            </p>
          </div>
        </a>
      </div>

  </div>
</div>