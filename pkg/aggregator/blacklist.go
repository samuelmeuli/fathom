package aggregator

import (
	"bufio"
	"bytes"
	"github.com/gobuffalo/packr"
	"strings"
)

type blacklist struct {
	data []byte
}

func newBlacklist() (*blacklist, error) {
	box := packr.NewBox("data")
	blacklistData, err := box.Find("blacklist.txt")
	return &blacklist{data: blacklistData}, err
}

// Has returns true if the given domain appears on the blacklist
// Uses sub-string matching, so if usesfathom.com is blacklisted then this function will also return true for danny.usesfathom.com
func (b *blacklist) Has(r string) bool {
	if r == "" {
		return false
	}

	scanner := bufio.NewScanner(bytes.NewReader(b.data))
	domain := ""

	for scanner.Scan() {
		domain = scanner.Text()
		if strings.HasSuffix(r, domain) {
			return true
		}
	}

	return false
}
