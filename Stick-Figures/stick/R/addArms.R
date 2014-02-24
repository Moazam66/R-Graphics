#' add arms
#'
#' @title add arms
#' @param x: left bottom alignment of figure
#' @param y: left bottom alignment of figure
#' @param s: scale (default 1/100)
#' @param arms: single character "default" ("down"), "neutral", "up", "hip", "wave", 
#'     or numeric matrix with two rows for left and right coordinates
#' @param lwd: line weight
#' @param linecol: color of lines
#' @param shcol: color of shirt, or NULL to supress shirt (default \code{NULL})
#' @param torso: length 4 vector of x-y coordinates of top and bottom of torso
#' @param w: width parameter (default 5)
#' @return matrix of arms coordinates
#' @export
#' @examples
#'    plot(0:1, 0:1, type = "n")
#'    addArms(arms = "neutral", linecol = 2)
#'    addArms(arms = "hip", linecol = 4)
#'    addArms(arms = "wave", linecol = 5)
#'    addArms(shcol = 2)
#'    addArms(arms = "up", linecol = 3, shcol = 3)
#'    addArms(arms = "neutral", shcol = 4)

addArms <- function(x = 0, y = 0, s = 1 / 100, arms = "default", 
    lwd = 1, linecol = 1, shcol = NULL, torso = c(50, 60, 50, 35), w = 5) {
    
    # Draw torso
    
    lines(c(x + torso[1] * s, x + torso[3] * s), c(y + torso[4] * s, y + torso[2] * s), lwd = lwd, col = linecol)
    
    if (all(is.na(arms))) { arms <- "default" }
    
    if (is.character(arms) && length(arms) == 1) {
        
        arms <- switch(arms, 
            "neutral" = {
                matrix(c(25, 50, 75,
                    55, 55, 55), nrow = 2, byrow = TRUE)
            },
            "up" = {
                matrix(c(30, 50, 70,
                    65, 55, 65), nrow = 2, byrow = TRUE)
            },
            "hip" = {
                matrix(c(48, 37, 50, 63, 51,
                    40, 47, 55, 49, 62), nrow = 2, byrow = TRUE)
            },
            "wave" = {
                matrix(c(33, 38, 50, 63, 52,
                    78, 60, 55, 47, 40), nrow = 2, byrow = TRUE)
            },
                matrix(c(35, 50, 65,
                    35, 55, 35), nrow = 2, byrow = TRUE)
        )
    }
    
    lines(x = x + arms[1, ] * s, y = y + arms[2, ] * s, lwd = lwd, col = linecol)
    
    ccol <- ceiling(ncol(arms) / 2)
    
    ssign <- sign(arms[2, ccol + c(-1, 1)] - arms[2, ccol])
    
    ends <- rep(w / 4, times = 2)
    
    ends[ssign == -1] <- ends[ssign == -1] * -1
    
    if (!is.null(shcol)) {
        
        shirt <- matrix(c(torso[1], torso[1] - 7 * w / 5, torso[1] - 6 * w / 5, arms[1, ccol - 1] - ends[1], arms[1, ccol - 1] + ends[1] * ifelse(ssign[1] == 0, -1, 1), torso[3] - w, 
                    rev(c(torso[1], torso[1] + 7 * w / 5, torso[1] + 6 * w / 5, arms[1, ccol + 1] + ends[2], arms[1, ccol + 1] - ends[2] * ifelse(ssign[2] == 0, -1, 1), torso[3] + w)),
                    
                          torso[4], torso[4], arms[2, ccol] - 2 * w, arms[2, ccol - 1] - w / 4, arms[2, ccol - 1] + w / 4, (arms[2, ccol] + torso[2]) / 2, 
                    rev(c(torso[4], torso[4], arms[2, ccol] - 2 * w, arms[2, ccol + 1] - w / 4, arms[2, ccol + 1] + w / 4, (arms[2, ccol] + torso[2]) / 2))), 
            nrow = 2, byrow = TRUE)
        
        # Draw shirt
        polygon(x = x + s * shirt[1, ], y = y + s * shirt[2, ],
                col = shcol, border = linecol, lwd = lwd)
    }
    
    return(invisible(arms))
}