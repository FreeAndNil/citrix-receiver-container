FROM debian:11

COPY icaclient_*.deb /tmp

RUN apt update && \
	DEBIAN_FRONTEND=noninteractive apt install --no-install-recommends -y \
		firefox-esr \
		nano \
		pulseaudio \
		xdg-utils \
		/tmp/icaclient_*.deb && \
	rm /tmp/icaclient_*.deb && \
	apt clean && \
	rm -rf /var/lib/apt/lists/*

RUN ln -sr /usr/share/ca-certificates/mozilla/* /opt/Citrix/ICAClient/keystore/cacerts/ && \
	c_rehash /opt/Citrix/ICAClient/keystore/cacerts/ && \
	xdg-mime default wfica.desktop application/x-ica

COPY entrypoint.sh /
COPY prefs.js /prefs.js
ENTRYPOINT ["/entrypoint.sh"]
