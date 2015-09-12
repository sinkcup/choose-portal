<style type="text/css">
.module_filter ul li
{
    margin:0 0 0.5em 0;
}
.module_filter ul ul
{
    display:inline;
    margin:0 0 0 1em;
}
.module_filter ul ul li
{
    display:inline;
    margin:0 1em 0 0;
}
.module_filter ul ul li a.visiting
{
    background:#ccc;
}
.module_filter ul ul li a.multi
{
    background:#f8f8f8;
    border-radius:3px;
    border:1px solid #8E8F8F;
    width:1em;
    height:1em;
    display:inline-block;
}
.module_filter p.filter_title
{
    background:#7DA7F0;
    background:-moz-linear-gradient(top,#7DA7F0,#6993DC);
    background:-webkit-gradient(linear,left top,left bottom,color-stop(0.28,#7DA7F0),color-stop(0.72,#6993DC));
    border-radius:5px 5px 0 0;
    color:#fff;
    padding:2px 3px;
}
.module_filter .filter_detail
{
    border:1px solid #DDD;
    border-radius:0 0 5px 5px;
    padding:3px 4px 10px 4px;
}
.module_filter li span.filter_name
{
    width:8em;
    float:left;
}
.module_filter iframe.add_img
{
    height:2em;
    border:none;
}
.module_filter .preview_img div
{
    width:170px;
    float:left;
}
</style>
<div class="module_filter">
    <p class="filter_title">筛选条件</p>
    <div class="filter_detail">
    <form method="post" action="add_process">
        <ul>
            <?php
                //循环行
                foreach($v['filter_rows'] as $row)
                {
                    //如果这一行不是数组，说明是单选
                    if(!is_array($row))
                    {
                        $attribute_name = $row;
                        echo '<li><span class="filter_name">' . $v['attribute_name_wlp'][$attribute_name] . '</span>';
                        echo '<ul class="one_column">';
                        foreach($v['attribute_value'][$attribute_name] as $value=>$value_display)
                        {
                            $tmp = $v['uri_where'];
                            $tmp[$attribute_name] = $value;
                            echo '<li><input type="radio" name="' . $attribute_name . '" id="' . $attribute_name . '_' . $value . '" value="' . $value . '" />';
                            echo '<label for="' . $attribute_name . '_' . $value . '">'.$value_display.'</label></li>';
                        }
                        echo '</ul></li>';
                    }
                    else
                    {
                        $tmp = array_keys($row);
                        $row_name = $tmp[0];
                        echo '<li><span class="filter_name">' . $v['attribute_name_wlp'][$row_name] . '</span>';
                        echo '<ul class="one_column">';
                        $tmp = array_values($row);

                        foreach($tmp[0] as $attribute_name)
                        {
                            echo '<li><input type="checkbox" name="' . $attribute_name . '" id="' . $attribute_name . '" value="1" />';
                            echo '<label for="' . $attribute_name . '">' . $v['attribute_name_wlp'][$attribute_name] . '</lable></li>';
                        }
                        echo '</ul></li>';
                    }
                }
                foreach($v['detail_attribute'] as $attribute_name)
                {
                    echo '<li><span class="filter_name"><label for="' . $attribute_name . '">' . $v['detail_attribute_name_wlp'][$attribute_name] . '</lable></span>';
                    echo '<input type="text" name="' . $attribute_name . '" id="' . $attribute_name . '" value="" /></li>';
                }
            ?>
            </ul>
        </ul>
        <div id="preview_img" class="preview_img">
        </div>
        <div class="clear">
        </div>
        <iframe src="/add_img" class="add_img">
        </iframe>
        <input type="submit" />
    </form>
    </div>
</div>
