<style type="text/css">
.module_group_hidden_categories_nav ul
{
    display:none;
    margin:0 0 0 1em;
}
.module_group_hidden_categories_nav ul.visiting
{
    display:inline;
}
.module_group_hidden_categories_nav ul li
{
    display:inline;
    margin:0 1em 0 0;
}
.module_group_hidden_categories_nav ul li a
{
    color:#000;
}
.module_group_hidden_categories_nav ul li a.visiting
{
    font-weight:bold;
}
.module_group_hidden_categories_nav p.group_title
{
    background:#7DA7F0;
    background:-moz-linear-gradient(top,#7DA7F0,#6993DC);
    background:-webkit-gradient(linear,left top,left bottom,color-stop(0.28,#7DA7F0),color-stop(0.72,#6993DC));
    border-radius:5px 5px 0 0;
    color:#fff;
    padding:2px 3px;
}
.module_group_hidden_categories_nav .sub_groups
{
    border:1px solid #DDD;
    border-radius:0 0 5px 5px;
    padding:3px 4px 10px 4px;
}
.module_group_hidden_categories_nav .sub_groups p.title
{
    font-weight:normal;
    padding:0 0 0 8px;
}
.module_group_hidden_categories_nav .sub_groups .visiting p.title
{
    font-weight:bold;
    background:#fff url('http://img.shaixuan.org/bb1a2eae1faa91a6d79ab667f368d8ab.png') no-repeat left center;
}
</style>
<div class="module_group_hidden_categories_nav">
<?php
foreach($v['group'] as $group_name => $data)
{
    echo '<p class="group_title">' . $group_name . '</p>';
    echo '<div class="sub_groups">';
    foreach($data as $title => $categories)
    {
        $html = '';
        $show_this = FALSE;
        foreach($categories as $category_name=>$display)
        {
            $new_uri = $v['uri_data'];
            $new_uri['category_name'] = $category_name;
            $html .= '<li><a href="'.encodeFilterUri($new_uri).'"';
            if($v['uri_data']['category_name']==$category_name)
            {
                $html .= ' class="visiting"';
                $show_this = TRUE;
            }
            $html .= '>'.$display.'</a></li>';
        }
        if($show_this == TRUE)
        {
            $html = '<div class="sub_group visiting"><p class="title">' . $title . '</p>' . '<ul class="visiting">' . $html;
        }
        else
        {
            $html = '<div class="sub_group"><p class="title">' . $title . '</p>' . '<ul>' . $html;
        }
        echo $html;
        echo '</ul>';
        echo '</div>';
    }
    echo '</div>';
}
?>
</div>
<script type="text/javascript">
var elements = document.getElementsByTagName('div');
var module_group_hidden_categories_nav = null;
for(var i=0,l=elements.length;i<l;i++)
{
    if(elements[i].className == 'module_group_hidden_categories_nav')
    {
        module_group_hidden_categories_nav = elements[i];
        var nav_div_elements = module_group_hidden_categories_nav.getElementsByTagName('div');
        var sub_groups = null;
        for(var i1=0,l1=nav_div_elements.length;i1<l1;i++)
        {
            if(nav_div_elements[i1].className == 'sub_groups')
            {
                sub_groups = nav_div_elements[i1];
                var sub_groups_p_elements = sub_groups.getElementsByTagName('p');
                for(var i2=0,l2 = elements.length;i2<l2;i2++)
                {
                    if(sub_groups_p_elements[i2].className == 'title')
                    {
                        sub_groups_p_elements[i2].onclick = function()
                        {
                            var ul = this.nextSibling;
                            if(ul.className=='visiting')
                            {
                                ul.className = '';
                            }
                            else
                            {
                                ul.className = 'visiting';
                            }
                        }
                    }
                }
            }
        }
    }
}
</script>
