# $FreeBSD$

PORTNAME=       arbtt
PORTVERSION=    0.10.2
PORTREVISION=   1
CATEGORIES=     deskutils haskell

MAINTAINER=     mail@dbalan.in
COMMENT=        cross-platform, completely automatic time tracker.

LICENSE=        GPLv2
LICENSE_FILE=   ${WRKSRC}/LICENSE

USES=           xorg cabal
USE_XORG=       x11
USE_CABAL=      X11-1.9.1 \
                aeson-1.4.7.1_1 \
                attoparsec-0.13.2.4 \
                base-compat-0.11.1 \
                base-compat-batteries-0.11.1 \
                base-orphans-0.8.2 \
                bytestring-progress-1.4 \
                conduit-1.3.2 \
                data-default-0.7.1.1 \
                exceptions-0.10.4_1 \
                integer-logarithms-1.0.3_2 \
                mono-traversable-1.0.15.1 \
                pcre-light-0.4.1.0 \
                primitive-0.7.0.1 \
                resourcet-1.2.4 \
                scientific-0.3.6.2 \
                split-0.2.3.4 \
                strict-0.3.2 \
                tagged-0.8.6_2 \
                terminal-progress-bar-0.4.1 \
                terminal-size-0.3.2.1 \
                th-abstraction-0.3.2.0 \
                time-compat-1.9.3 \
                unliftio-core-0.2.0.1_1 \
                uuid-types-1.0.3_2 \
                vector-0.12.1.2 \
                vector-algorithms-0.8.0.3 \
                hsc2hs-0.68.7

EXECUTABLES=      arbtt-capture arbtt-stats arbtt-recover arbtt-import arbtt-dump
SKIP_CABAL_PLIST= yes

OPTIONS_DEFINE=   MANPAGES
OPTIONS_SUB=      yes
MANPAGES_DESCRIBE= Build and/or install manpages

OPTIONS_DEFAULT=  MANPAGES

MANPAGES_BUILD_DEPENDS= ${LOCALBASE}/share/xsl/docbook/manpages/profile-docbook.xsl:textproc/docbook-xsl \
                    xsltproc:textproc/libxslt

post-patch-MANPAGES-on:
	@${REINPLACE_CMD} -e 's|/usr/share/xml/docbook/stylesheet/nwalsh/manpages/profile-docbook.xsl|/usr/local/share/xsl/docbook/manpages/profile-docbook.xsl|g' ${WRKSRC}/doc/Makefile

post-install:
	${MKDIR} ${STAGEDIR}${EXAMPLESDIR}
	${INSTALL_MAN} ${WRKSRC}/categorize.cfg ${STAGEDIR}${EXAMPLESDIR}
	${INSTALL_MAN} ${WRKSRC}/arbtt-capture.desktop ${STAGEDIR}${EXAMPLESDIR}

post-install-MANPAGES-on:
	${MKDIR} ${STAGEDIR}${DOCSDIR}
	cd ${WRKSRC}/doc && ${MAKE} man
.for l in arbtt-stats arbtt-recover arbtt-import arbtt-dump arbtt-capture
	${INSTALL_MAN} ${WRKSRC}/doc/man/man1/${l}.1 ${STAGEDIR}${PREFIX}/man/man1/
.endfor

.include <bsd.port.mk>
