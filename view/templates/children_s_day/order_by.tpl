<style type="text/css">
.module_order_by
{
    margin:20px 0 10px;
    border-top:4px solid #489BF0;
}
.module_order_by p.title
{
    float:left;
}
.module_order_by div.order_by
{
    float:left;
}
.module_order_by ul li
{
    float:left;
    display:block;
}
.module_order_by ul li a
{
    color:#666;
    display:block;
    padding:0 0.5em;
}
.module_order_by ul li a.visiting
{
    background:#499BF0;
    color:#fff;
}
</style>
<div class="module_order_by">
    <p class="title">排序</p>
    <div class="order_by">
    <ul>
<?php
foreach($v['order_by'] as $attribute_name => $data)
{
    $tmp = $v['uri_where'];
    //如果已经按照这个排序了
    if(isset($data[$v['uri_where']['order_by']]))
    {
        if(count($data)>1)
        {
            unset($data[$v['uri_where']['order_by']]);
        }
        echo '<li><a class="visiting"';
    }
    else
    {
        echo '<li><a';
    }
    foreach($data as $num=>$str)
    {
        $tmp['order_by'] = $num;
        echo ' href="' . encodeFilterUri($uri_data,$tmp) . '"';
        echo '>'. $v['attribute_name_wlp'][$attribute_name] . '</a></li>';
        break; //只有1条
    }
}
?>
    </ul>
    </div>
    <div class="clear"></div>
</div>
