<?php
$tmp = scandir(dirname(__FILE__) . '/../conf/group/');
foreach($tmp as $one)
{
    if(stripos($one, '.conf') !== false)
    {
        $tmp2 = explode('.', $one);
        $v['groups'][$tmp2[0]] = ConfigParserLib::get('group/' . $tmp2[0] , 'nav[\'' . $written_language_tag . '\']');
    }
}
?>
