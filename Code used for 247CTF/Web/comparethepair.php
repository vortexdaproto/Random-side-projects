<?php
$a = md5("f789bbc328a3d1a3cd9f5eb48d46dcf698dc");
if ($a == 0e902564435691274142490923013038) {
    echo "yes";
} else {
    echo "no";
}

$n = 20;
while(true) {
    $a = bin2hex(random_bytes($n / 2));
    $b = md5("f789bbc328a3d1a3" . $a);
    if ($b == 0) {
        echo $a . " : " . $b;
        break;
    }
}
