from pathlib import Path

import qrcode
from qrcode.constants import ERROR_CORRECT_H


OUTPUTS = {
    "學生版.png": "https://easyshih-ux.github.io/color-game-2026/index.html",
    "教師版.png": "https://easyshih-ux.github.io/color-game-2026/teacher-checkpoints.html",
}


def create_qr(url: str, output_path: Path) -> None:
    qr = qrcode.QRCode(
        version=None,
        error_correction=ERROR_CORRECT_H,
        box_size=24,
        border=4,
    )
    qr.add_data(url)
    qr.make(fit=True)
    image = qr.make_image(fill_color="black", back_color="white")
    image.save(output_path)


def main() -> None:
    output_dir = Path("QR")
    output_dir.mkdir(exist_ok=True)
    for filename, url in OUTPUTS.items():
        create_qr(url, output_dir / filename)


if __name__ == "__main__":
    main()
