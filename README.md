**Master**: [![Build Status Master](https://travis-ci.org/monshq/board.png?branch=master)](https://travis-ci.org/monshq/board)
**Latest**: [![Build Status Latest Commit](https://travis-ci.org/monshq/board.png)](https://travis-ci.org/monshq/board)

[![Dependency Status](https://gemnasium.com/monshq/board.png)](https://gemnasium.com/monshq/board)

[![Code Climate](https://codeclimate.com/github/monshq/board.png)](https://codeclimate.com/github/monshq/board)

[![Coveralls](https://coveralls.io/repos/monshq/board/badge.png?branch=master)](https://coveralls.io/r/monshq/board)

[![githalytics.com alpha](https://cruel-carlota.pagodabox.com/062fba682de7b0654f14a080676c3da1 "githalytics.com")](http://githalytics.com/monshq/board)

Для работы полнотекстового поиска по объявлениям необходимо иметь запущенный ElasticSearch:

```
wget download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-0.20.4.deb
sudo dpkg -i elasticsearch-0.20.4.deb
```

Для работы resque необходимо установить redis https://gist.github.com/brow/1315952
Workers запускаются через foreman вместе с приложением. Для запуска
front-end выполните resque-web в консоле
