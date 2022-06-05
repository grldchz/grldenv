count=$(find grldservice -name *.php 2>/dev/null | wc -l)
if [ $count != 0 ]
then
    for f in $(find grldservice -name *.php)
    do
        echo "******************* Updating $f";
        sed -i 's/GRLDCHZ/grilledcheeseoftheday.com/g' $f
    done
fi
count=$(find grldchz-ts/src \( -name \*.css -o -name \*.ts -o -name \*.tsx \) 2>/dev/null | wc -l)
if [ $count != 0 ]
then
    for f in $(find grldchz-ts/src \( -name \*.css -o -name \*.html -o -name \*.ts -o -name \*.tsx \))
    do
        echo "******************* Updating $f";
        sed -i 's/GRLDCHZ/grilledcheeseoftheday.com/g' $f
    done
fi
count=$(find grldchz-ts/public -name *.html 2>/dev/null | wc -l)
if [ $count != 0 ]
then
    for f in $(find grldchz-ts/public -name *.html)
    do
        echo "******************* Updating $f";
        sed -i 's/GRLDCHZ/grilledcheeseoftheday.com/g' $f
    done
fi
