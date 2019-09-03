# osur: Package to import osu data to R

<!-- badges: start -->
[![Travis build status](https://travis-ci.org/its-gazza/osur.svg?branch=master)](https://travis-ci.org/its-gazza/osur)
<!-- badges: end -->

## Installation

``` r
# Install from GitHub
devtools::install_github("its-gazza/osur")
```

## Usage

### get\_player

**Overview**  
Retrieve general player info

``` r
get_player(user = "peppy", 
           key = key, # osu-api key
           type = "string") %>% 
  kable()
```

| user\_id | username | join\_date          | count300 | count100 | count50 | playcount | ranked\_score | total\_score | pp\_rank |   level | pp\_raw | accuracy | count\_rank\_ss | count\_rank\_ssh | count\_rank\_s | count\_rank\_sh | count\_rank\_a | country | total\_seconds\_played | pp\_country\_rank |
| -------: | :------- | :------------------ | -------: | -------: | ------: | --------: | ------------: | -----------: | -------: | ------: | ------: | -------: | --------------: | ---------------: | -------------: | --------------: | -------------: | :------ | ---------------------: | ----------------: |
|        2 | peppy    | 2007-08-28 03:09:12 |   653288 |   116543 |   24642 |      7246 |     426251881 |   1893541089 |   362108 | 65.9858 | 765.859 |       96 |              15 |                0 |             70 |               0 |            115 | AU      |                 717782 |              8359 |

### get\_player\_pp

**Overview**  
Retrieve player pp info

``` r
get_player_pp(user = "peppy", 
              key = key, # osu-api key
              type = "string", 
              limit = 5) %>% # Select top 5, maximum is 100
  kable()
```

| beatmap\_id |   score | maxcombo | count50 | count100 | count300 | countmiss | countkatu | countgeki | perfect | enabled\_mods | user\_id | date                | rank |      pp |
| :---------- | ------: | -------: | ------: | -------: | -------: | --------: | --------: | --------: | :------ | ------------: | :------- | :------------------ | :--- | ------: |
| 22423       | 2669868 |      450 |       0 |        0 |      254 |         0 |         0 |        38 | 1       |         16416 | 2        | 2014-03-25 03:58:04 | X    | 64.1462 |
| 258467      | 2063452 |      349 |       0 |        0 |      239 |         0 |         0 |        61 | 1       |             0 | 2        | 2014-06-24 13:49:54 | X    | 49.9275 |
| 266885      | 8235244 |      712 |       0 |       11 |      470 |         0 |        11 |        85 | 0       |             0 | 2        | 2014-03-18 10:25:25 | S    | 48.9492 |
| 197337      | 2111674 |      388 |       0 |       16 |      221 |         3 |        11 |        35 | 0       |             0 | 2        | 2014-07-22 09:18:53 | A    | 45.7289 |
| 119488      | 4381728 |      589 |       0 |        4 |      298 |         0 |         3 |        77 | 1       |             0 | 2        | 2014-07-24 08:29:59 | S    | 42.1802 |

### get\_beatmap

**Overview**  
Get beatmap info from osu server

``` r
get_beatmap(beatmap_id = 890190,
            key = key) %>% 
  kable()
```

| beatmapset\_id | beatmap\_id | approved | total\_length | hit\_length | version | file\_md5                        | diff\_size | diff\_overall | diff\_approach | diff\_drain | mode | approved\_date      | last\_update        | artist                         | title | creator | creator\_id | bpm | source | tags                                                                                                                                                                                                                                                                                                        | genre\_id | language\_id | favourite\_count | playcount | passcount | max\_combo | difficultyrating |
| :------------- | :---------- | :------- | ------------: | ----------: | :------ | :------------------------------- | ---------: | ------------: | -------------: | ----------: | :--- | :------------------ | :------------------ | :----------------------------- | :---- | :------ | :---------- | --: | :----- | :---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | :-------- | :----------- | ---------------: | --------: | --------: | ---------: | ---------------: |
| 410162         | 890190      | 1        |           528 |         464 | Himei   | be1c44c57ad5340c863971481afe561b |        4.5 |             9 |            9.7 |           5 | 0    | 2016-04-12 00:20:14 | 2016-04-05 00:02:31 | Imperial Circus Dead Decadence | Uta   | Kite    | 134572      | 140 |        | nanomortis extol ou song declare express lolcubes ode to the dreadful sacrament 惨劇の血に赫く染まった愛と絶望の黒い死とが紡ぐ最期の物語 sangeki no chi ni kagayaku somatta ai to zetsubou no kuroi shitoga tsumugu saigo no monogatari rib:y(uhki) l.g.c. kim kylie hull vaguedge another stream kimiko peath2 tome あにょ reino hellnear | 4         | 3            |             1744 |   2587804 |     86204 |       3470 |          7.19601 |

### mod\_detect

**Overview**  
Convert numeric mod to a character list of mod

``` r
mod_detect(value = 80)
```

    ## [1] "HR,DT"

### mod\_convert

**Overview**  
Convert difficulty base on mods

This will convert the following difficulties:  
\* Overall difficulty (diff\_overall) \* Size difficulty (diff\_size) \*
Drain difficulty (diff\_drain) \* Approach rate difficulty
(diff\_approach)

``` r
mod_convert(beatmap_id = 804164, 
            enable_mod = 64, # 64 = DT
            key = key) %>% 
  kable()
```

| beatmapset\_id | beatmap\_id | approved | total\_length | hit\_length | version | file\_md5                        | diff\_size | diff\_overall | diff\_approach | diff\_drain | mode | approved\_date      | last\_update        | artist | title   | creator  | creator\_id | bpm | source | tags                                                                                                               | genre\_id | language\_id | favourite\_count | playcount | passcount | max\_combo | difficultyrating | mods |
| :------------- | :---------- | :------- | ------------: | ----------: | :------ | :------------------------------- | ---------: | ------------: | -------------: | ----------: | :--- | :------------------ | :------------------ | :----- | :------ | :------- | :---------- | --: | :----- | :----------------------------------------------------------------------------------------------------------------- | :-------- | :----------- | ---------------: | --------: | --------: | ---------: | ---------------: | :--- |
| 366440         | 804164      | 1        |           130 |         128 | FOREVER | 828e4ce6f1333e2a92265f3d5c9cc9db |          4 |           8.5 |          10.33 |           7 | 0    | 2015-12-25 22:01:51 | 2015-12-16 11:18:24 | Reol   | MONSTER | handsome | 2123087     | 246 |        | umetora reworu gokusaishoku -kevincela- regraz sharkie bearizm vinxis asahina momoko mokori fort byfar れをる 極彩色 梅とら | 4         | 3            |             3158 |   1789236 |    149433 |        982 |         5.897964 |      |

Note only `diff_overall`, `diff_size`, `diff_drain`, `diff_approach`
will be changed

### ar\_convert

**Overview**  
Convert AR base on mod

``` r
ar_convert(ar = 7, 
           enable_mod = 64) # 64 = DT
```

    ## [1] 9

### map\_acc

**Overview**  
Calculate map accuracy

``` r
map_acc(count50 = 0,
        count100 = 27,
        count300 = 2565)
```

    ## [1] 99.31

## For more information

  - osu-api: <https://github.com/ppy/osu-api/wiki>
  - Mod value calculation:
    <https://osu.ppy.sh/help/wiki/Beatmap_Editor/Song_Setup>  
  - Difficulty calculation:
    <https://osu.ppy.sh/help/wiki/Game_Modifiers>
