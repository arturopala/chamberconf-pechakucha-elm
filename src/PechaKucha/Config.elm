module PechaKucha.Config (..) where


fps =
    1


pageTimeout =
    20


pageFrames =
    pageTimeout * fps


roundFrames =
    (pageTimeout // 5) * fps


initialDelay =
    2 * fps
