from pathlib import Path
import re

from PIL import Image


ROOT = Path(__file__).resolve().parent
PAGES = [
    "index.html",
    "hue-intro.html",
    "index01.html",
    "hue-password.html",
    "brightness-intro.html",
    "index02.html",
    "brightness-password.html",
    "chroma-intro.html",
    "index03.html",
    "chroma-password.html",
    "elements-intro.html",
    "elements-password.html",
    "evaluation_google_sheet.html",
    "final-ending.html",
]
PNG_REFERENCE = re.compile(r"(?P<quote>[\"'])(?P<path>[^\"'<>]+?\.png)(?P=quote)", re.IGNORECASE)


def local_pngs(page_text):
    for match in PNG_REFERENCE.finditer(page_text):
        reference = match.group("path")
        if "://" in reference or reference.startswith("data:"):
            continue
        source = ROOT.joinpath(*reference.split("/"))
        if source.is_file():
            yield reference, source


page_texts = {page: (ROOT / page).read_text(encoding="utf-8") for page in PAGES}
references = {}
for page_text in page_texts.values():
    for reference, source in local_pngs(page_text):
        references[reference] = source

original_bytes = 0
webp_bytes = 0
for reference, source in sorted(references.items()):
    target = source.with_suffix(".webp")
    original_bytes += source.stat().st_size
    with Image.open(source) as image:
        image.load()
        if image.mode not in ("RGB", "RGBA"):
            image = image.convert("RGBA" if "transparency" in image.info else "RGB")
        image.save(target, "WEBP", quality=86, method=6)
    webp_bytes += target.stat().st_size

for page, page_text in page_texts.items():
    updated = page_text
    for reference in references:
        updated = updated.replace(reference, reference[:-4] + ".webp")
    if updated != page_text:
        (ROOT / page).write_text(updated, encoding="utf-8", newline="")

saved = original_bytes - webp_bytes
print(f"converted={len(references)}")
print(f"original_mb={original_bytes / 1024 / 1024:.1f}")
print(f"webp_mb={webp_bytes / 1024 / 1024:.1f}")
print(f"saved_mb={saved / 1024 / 1024:.1f}")
