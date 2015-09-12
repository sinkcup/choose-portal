<?php
$tmp = $v['uri_where'];
unset($tmp['page_num']);
unset($tmp['order_by']);
$s = '';
foreach($tmp as $name=>$value)
{
    if($value!=0)
    {
        $s .= $name . '=' . $value .'&';
    }
}
$page_size = ConfigParserLib::get('fd','products_preview_page_size');
if((!isset($v['uri_where']['page_num']))||empty($v['uri_where']['page_num']))
{
    $page_num = 1;
    $v['uri_where']['page_num'] = 1;
}
else
{
    $page_num = $v['uri_where']['page_num'];
}
if((!isset($v['uri_where']['order_by']))||strval($v['uri_where']['order_by'])==='00')
{
    $order_by = 1;
    $v['uri_where']['order_by'] = 1;
}
$tmp = array();
foreach($v['uri_where'] as $key=>$value)
{
    if($value!=='00')
    {
        $tmp[$key] = $value;
    }
}
unset($tmp['page_num']);
$tmp['skip'] = (intval($page_num) - 1)*$page_size;
$tmp['limit'] = $page_size;
//$tmp['need'] = $page_size; //todo fields
$order_by_conf = ConfigParserLib::get('product/' . $uri_data['category_name'], 'order_by');
$v['order_by_title_tail_wlp'] = ConfigParserLib::get('product/' . $uri_data['category_name'] , 'order_by_title_tail_wlp[\'' . $written_language_tag .'\']');
foreach($order_by_conf as $attribute_name=>$data)
{
    if(isset($data[$v['uri_where']['order_by']]))
    {
        $tmp['order_by'] = $attribute_name;
        $tmp['order_desc'] = $data[$v['uri_where']['order_by']]=='desc' ? '1' : 0;
        $v['title'] .= ' ' . $v['order_by_title_tail_wlp'][$attribute_name][$data[$v['uri_where']['order_by']]];
        break;
    }
}
$params = array(
    'get' => $tmp
);
$map = ConfigParserLib::get('category', 'category_map');
$v['products_preview'] = FdHelperLib::crudApi('products/' . array_search($uri_data['category_name'], $map) . '/basic', $written_language_tag, $params);

//$output[] = 'products_preview';
?>
