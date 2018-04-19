{def $zones = $#node.data_map.page.content.zones
     $this_zone = false()
     $append_zone_name = ''}
{foreach $zones as $zone}
    {foreach $zone.blocks as $b}
        {if $b.id|eq( $block.id )}
            {set $this_zone = $zone}
            {break}
        {/if}
    {/foreach}
{/foreach}

{def $valid_nodes = $block.valid_nodes}

{if $block.type|eq( 'ItemTree' )}
    {def $subtree = array()}
    {foreach $valid_nodes as $n}
        {set $subtree = $subtree|append( $n.node_id )}
    {/foreach}
    {def $search_nodes = fetch( 'ezfind', 'search', hash( 'subtree_array', $subtree, 'limit', 3, 'sort_by', hash( 'published', false() ) ) )}
    {set $valid_nodes = $search_nodes.SearchResult}
{elseif $block.type|eq( 'ItemChildren' )}
    {def $classes = cond( $block.custom_attributes.class|ne( '' ), $block.custom_attributes.class|explode( ',' ), array() )
         $limit = cond( is_set( $block.custom_attributes.limit ), $block.custom_attributes.limit, 10 )
         $offset = cond( is_set( $block.custom_attributes.offset ), $block.custom_attributes.offset, 0 )
         $parent_node_id = cond( is_set( $block.custom_attributes.parent_node_id ), $block.custom_attributes.parent_node_id, 0 ) }
    {if $parent_node_id|eq(0)}
        <div class="warning"><strong>Avviso per l'editor:</strong><br/>Inserire un nodo <em>sorgente</em> valido.</div>
        {set $valid_nodes = array()}
    {else}
        {def $classes_hash = hash()
             $parent_node = fetch( 'content', 'node', hash( 'node_id', $parent_node_id ) )}
        {if $classes|count()}
            {set $classes_hash = hash( 'class_filter_type', 'include', 'class_filter_array', $classes )}
        {/if}
        {set $valid_nodes = fetch( 'content', 'list', hash(
                                                    'parent_node_id', $parent_node.node_id,
                                                    'sort_by', $parent_node.sort_array,
                                                    'limit', $limit,
                                                    'offset', $offset
                                                    )|merge( $classes_hash ) )}
    {/if}
{/if}
<!-- BLOCK: START -->

<div class="block block-type-itemlist block-type-{$block.view}">
{if $block.name}
<div class="block-header">
    {if is_set($parent_node)}
    <h2 class="blocktitle"><a href={$parent_node.url_alias|ezurl()}>{$block.name|wash()}</a></h2>    
    {else}
    <h2 class="blocktitle">{$block.name|wash()}</h2>
    {/if}
</div>
{/if}

{ezcss_require( array( 'carousel.css', 'arrows.css' ) )}	
{ezscript_require(array( 'ezjsc::jquery', 'jcarousel.js' ) )}

<script type="text/javascript">
{literal}
$(document).ready(function() {
        var carousel = null;
        function carouselInitCallback(c){
            carousel = c;
            // Disable autoscrolling if the user clicks the prev or next button.
            carousel.buttonNext.bind('click', function() {
                carousel.startAuto(0);
            });
        
            carousel.buttonPrev.bind('click', function() {
                carousel.startAuto(0);
            });
        
            // Pause autoscrolling if the user moves with the cursor over the clip.
            carousel.clip.hover(function() {
                carousel.stopAuto();
            }, function() {
                carousel.startAuto();
            });
        }
        $("#carousel-{/literal}{$block.id}{literal} ul.jcarousel-list").jcarousel({auto: 6,wrap: 'last', scroll: 1,initCallback: carouselInitCallback});
        var resizeCarousel = function(){
            var canvasWidth = parseInt($("#carousel-{/literal}{$block.id}{literal}").width());
            var containerPaddingLeft = parseInt($("#carousel-{/literal}{$block.id}{literal} div.jcarousel-container-horizontal").css('padding-left'));
            var containerPaddingRight = parseInt($("#carousel-{/literal}{$block.id}{literal} div.jcarousel-container-horizontal").css('padding-right'));
            var containerBorderLeft = parseInt($("#carousel-{/literal}{$block.id}{literal} div.jcarousel-container-horizontal").css('border-left-width'));
            var containerBorderRight = parseInt($("#carousel-{/literal}{$block.id}{literal} div.jcarousel-container-horizontal").css('border-right-width'));
            var containerWidth = canvasWidth - containerPaddingLeft - containerPaddingRight - containerBorderLeft - containerBorderRight;
            $("#carousel-{/literal}{$block.id}{literal} div.jcarousel-container-horizontal, #carousel-{/literal}{$block.id}{literal} div.jcarousel-clip").width(containerWidth);
            
            var defaultItemWidth = parseInt($("#carousel-{/literal}{$block.id}{literal} li.jcarousel-item").css('width'));
            var defaultItemPaddingLeft = parseInt($("#carousel-{/literal}{$block.id}{literal} li.jcarousel-item").css('padding-left'));
            var defaultItemPaddingRight = parseInt($("#carousel-{/literal}{$block.id}{literal} li.jcarousel-item").css('padding-right'));
            var numItems = Math.ceil(containerWidth/defaultItemWidth/2);
            var newItemWidth = (parseInt(containerWidth/numItems) - defaultItemPaddingLeft - defaultItemPaddingRight);
            $("#carousel-{/literal}{$block.id}{literal} li.jcarousel-item").width(newItemWidth);
            
            var ItemsWidth = (newItemWidth + defaultItemPaddingLeft + defaultItemPaddingRight) * $("#carousel-{/literal}{$block.id}{literal} li.jcarousel-item").length ;
            $("#carousel-{/literal}{$block.id}{literal} ul.jcarousel-list").css('width', ItemsWidth);
        }
        resizeCarousel();
});
{/literal}
</script>

<div id="carousel-{$block.id}" class="banner-carousel float-break">
    <ul class="jcarousel-list">
    {if $valid_nodes|count()|gt(0)}
        {foreach $valid_nodes as $banner}
            {if and(is_set($banner.data_map.image), $banner.data_map.image.has_content)}
                {node_view_gui content_node=$banner view=item_carousel zone=$this_zone}  
            {/if}
        {/foreach}
    {/if}		
    </ul>
</div>

</div>
{undef}