FROM ruby:alpine

RUN wget https://github.com/kaityo256/yaml_cv/archive/master.zip
RUN wget https://moji.or.jp/wp-content/ipafont/IPAexfont/IPAexfont00401.zip
RUN unzip -j master.zip
RUN unzip -j IPAexfont00401.zip

FROM ruby:alpine

RUN apk add --no-cache inotify-tools
RUN gem install prawn

COPY --from=0 *.rb /opt/yaml_cv/
COPY --from=0 *.ttf /opt/yaml_cv/fonts/
COPY --from=0 IPA_Font_License_Agreement_v1.0.txt /opt/yaml_cv/fonts/

COPY make_cv.sh /usr/local/bin/make_cv.sh

WORKDIR /opt/yaml_cv
CMD ["make_cv.sh"]
