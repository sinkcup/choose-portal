<style type="text/css">
.module_products_preview .one_product
{
    float:left;
    width:24%;
    margin:0 0 10px 1%;
    overflow:hidden;
}
.module_products_preview .one_product img
{
    display:block;
    margin:0 auto;
}
.module_products_preview .one_product .name
{
    height:3.9em;
    overflow:hidden;
    text-align:center;
}
.module_products_preview .one_product .price
{
    text-align:center;
    padding:0 0 0 35px;
}
.module_products_preview .one_product .price a
{
    float:left;
}
.module_products_preview .one_product .price a.taobao
{
    display:block;
    width:100px;
    /*text-indent:-3000em;
    background:url('http://img.shaixuan.org/a08f2bc434f33840e42e545f53b0b451-80-autox20.png') no-repeat top left;*/
}
</style>
<div class="module_products_preview">
    <?php
    if(empty($v['products_preview']))
    {
        echo '';
    }
    else
    {
        foreach($v['products_preview'] as $data)
        {
            echo '<div class="one_product">';
            $product_uri = FdHelperLib::getProductUri($v['uri_data']['category_name'], $data['id']);
            echo '<a target="_blank" href="' . $product_uri . '">';
            if(!isset($data['preview_img'][0]))
            {
                $data['preview_img'][0] = 'c819fb540478b49efe571aa3e3dbad32.png';
            }
            echo '<img height="' . ConfigParserLib::get('fd', 'product_preview_img_height') . '" src="' . FdHelperLib::getImgUri($data['preview_img'][0], 'auto', ConfigParserLib::get('fd', 'product_preview_img_height')) . '" alt="" />';
            echo '</a>';
            echo '<div class="name">';
            echo '<a target="_blank" href="' . $product_uri . '">' . $data['name'] . '</a>';
            echo '<div class="price">';
            if(isset($data['price']) && $data['price']!=='' && isset($data['taobao_uri']) && !empty($data['taobao_uri']))
            {
                echo '<a target="_blank" href="' . $product_uri . '">' . '￥' . $data['price'] . '</a>';
                echo '<a target="_blank" href="' . $data['taobao_uri'] . '" class="taobao">购买</a>';
                //todo hard code 如何做多国货币支持？先不做，能挣钱再说，人民币够挣了吧？
            }
            echo '</div>';
            echo '</div>';
            echo '</div>';
        }
    }
    ?>
    <div class="clear"></div>
</div>
